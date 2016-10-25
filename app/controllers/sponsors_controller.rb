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
    if @sponsor.save
      redirect_to @sponsor, notice: 'Спонсор успешно создан.'
    else
      render :new
    end
  end

  def update
    if @sponsor.update(sponsor_params)
      redirect_to @sponsor, notice: 'Спонсор успешно изменен.'
    else
      render :edit
    end
  end

  def destroy
    @sponsor.destroy
    redirect_to sponsors_url, notice: 'Спонсор успешно удален.'
  end

  private
  
  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(:title, :specialization, :loyalty_factor, :cost_of_full_stake)#, :win_prize, :draw_prize, :lost_prize)
  end
end
