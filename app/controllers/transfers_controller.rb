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
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: I18n.t('flash.transfers.edited') }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
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
    params.require(:transfer).permit(:cost, :player_id)#, :vendor_id, :purchaser_id, :cost, :status)
  end
end
