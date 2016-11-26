class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_current_user

  private
  #TODO custom 404 page

  def set_current_user
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
      @current_user_team = @current_user.team if @current_user.team.present?
    end
  end

  def require_login
    if @current_user
      flash[:danger] = 'Требуется авторизация'
      redirect_to login_path
    end
  end
  def check_user
    if @current_user.blank?
      flash[:danger] = "Необходимо войти в систему для просмотра данной страницы!"
      redirect_to root_path
    end
  end

  def moderator_permission
    unless @current_user.try(:moderator?)
      flash[:danger] = 'Недостаточно прав'
      redirect_to login_path
    end
  end

  def admin_permission
    unless @current_user.try(:administrator?)
      flash[:danger] = 'Недостаточно прав'
      redirect_to login_path
    end
  end

  def render_error(msg = 'Доступ запрещён')
    flash[:render] = msg
    redirect_to root_path
  end
end
