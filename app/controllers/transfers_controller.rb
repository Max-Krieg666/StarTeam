class TransfersController < ApplicationController
  before_action :check_user
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    @transfers = Transfer.where(status: 0).page(params[:page])
  end

  def show
    @player = @transfer.player
  end

  def new
    @transfer = Transfer.new
    @player = Player.find(params[:player_id])
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @transfer = Transfer.new(transfer_params)
      pl = Player.find(transfer_params[:player_id])
      @transfer.cost = @transfer.cost.round(3)
      @transfer.vendor_id = pl.team_id
      @transfer.status = 0
      pl.update(status: 4)
      respond_to do |format|
        if @transfer.save
          format.html { redirect_to @transfer, notice: I18n.t('flash.transfers.created') }
          format.json { render :show, status: :created, location: @transfer }
        else
          format.html { render :new }
          format.json { render json: @transfer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    if transfer_params
      respond_to do |format|
        if @transfer.update(transfer_params)
          format.html { redirect_to @transfer, notice: I18n.t('flash.transfers.edited') }
          format.json { render :show, status: :ok, location: @transfer }
        else
          format.html { render :edit }
          format.json { render json: @transfer.errors, status: :unprocessable_entity }
        end
      end
    else
      # TODO + отослать оповещение продавцу о покупке его игрока
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
          @transfer.player.status = 0
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
          @transfer.update!(status: 1)
          @current_user_team.budget -= @transfer.cost
          @current_user_team.save!
          Operation.create(team_id: @current_user_team.id, sum: @transfer.cost, kind: false, title: 'Покупка игрока на трансферном рынке')
          @transfer.vendor.budget += @transfer.cost
          @transfer.vendor.save!
          Operation.create(team_id: @transfer.vendor.id, sum: @transfer.cost, kind: true, title: 'Продажа игрока на трансферном рынке')
          redirect_to @transfer.player, notice: I18n.t('flash.players.buyed')
        end
      end
    end
  end

  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, notice: I18n.t('flash.transfers.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def transfer_params
    params.require(:transfer).permit(:cost, :player_id) if params[:transfer]
  end
end
