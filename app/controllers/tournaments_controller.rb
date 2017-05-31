class TournamentsController < ApplicationController
  before_action :check_user

  def index
    @leagues = @current_user.country.leagues.where(active: true)
    @cups = @current_user.country.cups.where(active: true)
  end

  def all
  	# TODO для админа
  end

  def friendly
  end
end
