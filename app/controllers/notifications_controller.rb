class NotificationsController < ApplicationController
  before_action :check_user

  def index
    @notifications = @current_user.notifications
                                  .order('created_at desc')
                                  .page(params[:page])
    @current_user.unread_notifications.update_all(viewed: true) if @current_user.unread_notifications.count > 0
  end
end
