class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    @transfers = Transfer.where(status:'Активен').page(params[:page])
  end

  def show
  end

  def new
    @transfer = Transfer.new
  end

  def edit
  end

  def create
    @transfer = Transfer.new(transfer_params)
    pl=PlayerInTeam.find(transfer_params[:player_id])
    @transfer.vendor_id=pl.team_id
    @transfer.status='Активен'
    pl.update(status:'transfer')
    respond_to do |format|
      if @transfer.save
        format.html { redirect_to @transfer, notice: 'Трансферное предложение успешно создано.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: 'Трансферное предложение изменено.' }
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
      format.html { redirect_to transfers_url, notice: 'Трансферное предложение удалено.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def transfer_params
    params.require(:transfer).permit(:cost,:player_id)#, :vendor_id, :purchaser_id, :cost, :status)
  end
end
