class SessionsController < ApplicationController
  def new
    redirect_to @current_user if @current_user
  end

  def create
    @user = User.where(login: params[:login]).first
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: I18n.t('flash.sessions.authorization_succeeded')
    else
      flash[:danger] = I18n.t('flash.sessions.incorrect')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: I18n.t('flash.sessions.logout')
  end
end
