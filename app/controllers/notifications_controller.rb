class NotificationsController < ApplicationController
  before_action :check_user

  def index
    @user = @current_user
    @notifications = @user.notifications.order('created_at desc').page(params[:page])
    @user.unread_notifications.update_all(viewed: true) if @user.unread_notifications.count > 0
  end
end
