class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :set_locale
  before_action :set_current_user

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  # TODO custom 404

  def set_current_user
    return if session[:user_id].blank?
    @current_user = User.find(session[:user_id])
    @current_user_team = @current_user.team if @current_user.team.present?
  end

  def require_login
    return unless @current_user
    flash[:danger] = I18n.t('flash.authorization_required')
    redirect_to login_path
  end

  def check_user
    return if @current_user.present?
    flash[:danger] = I18n.t('flash.must_be_logged')
    redirect_to root_path
  end

  def moderator_permission
    return if @current_user&.moderator?
    flash[:danger] = I18n.t('flash.insufficient_privileges')
    redirect_to login_path
  end

  def admin_permission
    return if @current_user&.administrator?
    flash[:danger] = I18n.t('flash.insufficient_privileges')
    redirect_to login_path
  end

  def render_error(msg = I18n.t('flash.access_denied'))
    flash[:render] = msg
    redirect_to root_path
  end
end
