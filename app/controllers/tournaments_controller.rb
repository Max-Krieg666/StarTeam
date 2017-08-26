class TournamentsController < ApplicationController
  before_action :check_user

  def index
    @leagues = @current_user.country.leagues.where.not(status: 2)
    @cups = @current_user.country.cups.where.not(status: 2)
  end

  def all
    # TODO для админа
  end

  def friendly
  end
end
