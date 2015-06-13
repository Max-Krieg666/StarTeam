class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

  private

  def set_current_user
    if session[:user_id].present?
      @current_user=User.find(session[:user_id])
    end
  end

  def require_login
    if @current_user
      flash[:danger]='Требуется авторизация'
      redirect_to login_path
    end
  end
  def check_user
    if @current_user.blank?
      flash[:danger]="Необходимо войти в систему для просмотра данной страницы!"
      redirect_to root_path
    end
  end

  def manager_permission
    unless @current_user.try(:manager?)
      flash[:danger]='Недостаточно прав'
      redirect_to login_path
    end
  end

  def admin_permission
    unless @current_user.try(:administrator?)
      flash[:danger]='Недостаточно прав'
      redirect_to login_path
    end
  end

  def render_error(msg='Доступ запрещён')
    flash[:render]=msg
    redirect_to root_path
  end
end
