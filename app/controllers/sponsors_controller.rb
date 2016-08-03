class SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  before_action :admin_permission, except: [:show]

  def index
    @sponsors = Sponsor.page(params[:page])
  end

  def show
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    sp = sponsor_params[:cost_of_full_stake]
    @sponsor.win_prize = sp / 1000.0
    @sponsor.draw_prize = sp / 2000.0
    @sponsor.lost_prize = sp / 8000.0
    #respond_to do |format|
      if @sponsor.save
        #format.html { redirect_to @sponsor, notice: 'Спонсор успешно создан.' }
        #format.json { render :show, status: :created, location: @sponsor }
        redirect_to @sponsor, notice: 'Спонсор успешно создан.'
      else
        #format.html { render :new }
        #format.json { render json: @sponsor.errors, status: :unprocessable_entity }
        render :new
      end
    #end
  end

  def update
    #respond_to do |format|
      if @sponsor.update(sponsor_params)
        #format.html { redirect_to @sponsor, notice: 'Спонсор успешно изменен.' }
        #format.json { render :show, status: :ok, location: @sponsor }
        redirect_to @sponsor, notice: 'Спонсор успешно изменен.'
      else
        #format.html { render :edit }
        #format.json { render json: @sponsor.errors, status: :unprocessable_entity }
        render :edit
      end
    #end
  end

  def destroy
    @sponsor.destroy
    #respond_to do |format|
      #format.html { redirect_to sponsors_url, notice: 'Спонсор успешно удален.' }
      #format.json { head :no_content }
    redirect_to sponsors_url, notice: 'Спонсор успешно удален.'
    #end
  end

  private
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end

    def sponsor_params
      params.require(:sponsor).permit(:title, :specialization, :loyalty_factor, :cost_of_full_stake)#, :win_prize, :draw_prize, :lost_prize)
    end
end
