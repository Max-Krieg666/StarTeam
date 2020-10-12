class TournamentsController < ApplicationController
  before_action :check_user

  def index
    @leagues = @current_user.country.leagues.not_finished
    @cups = @current_user.country.cups.not_finished
  end

  def all
    # TODO для админа
  end

  def friendly
  end
end
