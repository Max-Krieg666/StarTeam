class TransfersController < ApplicationController
  before_action :check_user
  before_action :set_player, only: [:new, :create]
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    t = Transfer.where(status: :active).order(created_at: :desc)
    @transfers = t.limit(500).page(params[:page])
    @user_transfers = t.where(vendor_id: @current_user_team.id)
  end

  def show
    @player = @transfer.player
  end

  def new
    @transfer = Transfer.new
  end

  def edit; end

  def create
    if transfer_params[:cost].blank?
      flash[:danger] = I18n.t('flash.transfers.errors.cost_blank')
      redirect_to new_transfer_path(player_id: transfer_params[:player_id])
    else
      ActiveRecord::Base.transaction do
        @transfer = Transfer.new(transfer_params)
        @transfer.cost = @transfer.cost.round(3)
        @transfer.vendor_id = @player.team_id
        @transfer.status = :active
        @player.transfer!
        if @transfer.save
          flash[:success] = I18n.t('flash.transfers.created')
          redirect_to @transfer
        else
          render :new
        end
      end
    end
  end

  def update
    if transfer_params
      respond_to do |format|
        if @transfer.update(transfer_params)
          format.html { redirect_to @transfer, success: I18n.t('flash.transfers.edited') }
          format.json { render :show, status: :ok, location: @transfer }
        else
          format.html { render :edit }
          format.json { render json: @transfer.errors, status: :unprocessable_entity }
        end
      end
    else
      cb = @current_user_team.club_base
      if !@current_user_team
        flash[:danger] = I18n.t('flash.players.no_team')
        redirect_to @current_user
      elsif @transfer.status != 'active'
        flash[:danger] = I18n.t('flash.transfer.not_available')
        redirect_to @transfer
      elsif !cb
        flash[:danger] = I18n.t('flash.players.no_club_base')
        redirect_to @current_user_team
      elsif cb.capacity == @current_user_team.squad_size
        flash[:danger] = I18n.t('flash.players.club_base_low_level')
        redirect_to cb
      elsif @current_user_team.budget < @transfer.cost
        flash[:danger] = I18n.t('flash.players.not_enough_money')
        redirect_to @transfer
      else # приобретение игрока возможно
        ActiveRecord::Base.transaction do
          @transfer.player.team_id = @current_user_team.id
          @transfer.player.status = :active
          @transfer.player.save!
          # определять игрока по капитанству и месту в основе
          # if buy_processing_params[:basic] == 'true'
          #   @current_user_team.players.where(position1: @player.position1, basic: true).first.update(basic: false)
          #   @player.basic = buy_processing_params[:basic]
          # end
          # captain = @current_user_team.captain
          # if @player.skill_level > captain.skill_level
          #   @player.captain = true
          #   captain.update(captain: false)
          # end
          @transfer.player.careers.active.first.update(
            active: false, age_end: @transfer.player.age
          )
          @transfer.player.careers.create(
            age_begin: @transfer.player.age,
            team_title: @current_user_team.title
          )
          @transfer.update!(status: :completed, purchaser_id: @current_user_team.id)
          @current_user_team.budget -= @transfer.cost
          @current_user_team.save!
          @current_user_team.operations.create(
            sum: @transfer.cost,
            kind: false,
            title: I18n.t('messages.operation.buy_transfer')
          )
          @current_user.notifications.create(
            kind: 1, title: I18n.t(
              'messages.notification.sell_transfer',
              name: @transfer.player.name,
              team: @transfer.vendor.title,
              sum: @transfer.cost_to_currency
            )
          )
          @transfer.vendor.budget += @transfer.cost
          @transfer.vendor.save!
          @transfer.vendor.operations.create(
            sum: @transfer.cost,
            kind: true,
            title: I18n.t('messages.operation.sell_transfer')
          )
          @transfer.vendor.user.notifications.create(
            kind: 1, title: I18n.t(
              'messages.notification.buy_transfer',
              name: @transfer.player.name,
              team: @current_user_team.title,
              sum: @transfer.cost_to_currency
            )
          )
          redirect_to @transfer.player, success: I18n.t('flash.players.buyed')
        end
      end
    end
  end

  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, success: I18n.t('flash.transfers.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def set_player
    player_id = params[:player_id] || transfer_params[:player_id]
    @player = Player.find(player_id)
  end

  def transfer_params
    params.require(:transfer).permit(:cost, :player_id) if params[:transfer]
  end
end
