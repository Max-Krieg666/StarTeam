class SessionsController < ApplicationController

  def new
  end

  def create
    @user=User.where(login: params[:login]).first
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      redirect_to @user, notice: 'Авторизация прошла успешно'
    else
      flash[:danger]='Неверное имя пользователя или пароль'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Выход выполнен'
  end
end
