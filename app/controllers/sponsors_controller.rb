class SponsorsController < ApplicationController
  before_action :check_user
  before_action :admin_permission, except: [:show]
  before_action :set_sponsor

  def show
    @team = @sponsor.team
  end

  def edit
    @team = @sponsor.team
  end

  def update
    if @sponsor.update(sponsor_params)
      redirect_to [@sponsor.team, @sponsor], notice: I18n.t('flash.sponsors.edited')
    else
      render :edit
    end
  end

  private

  def set_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(
      :title, :specialization,
      :loyalty_factor, :cost_of_full_stake
    )
  end
end
