class OperationsController < ApplicationController
  before_action :check_user

  def index
    @team = @current_user_team
    @financies = @team.operations.order('created_at desc').page(params[:page])
  end
end
