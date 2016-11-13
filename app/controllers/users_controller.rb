class UsersController < ApplicationController
  #TODO подумать об отдельных методах на восстановление пароля, регистрацию и т.д.
  # 2й TODO разобраться с отправкой на email писем Confirmable
  # 3й TODO добавить модуль Recoverable собственноручный
  # 4й TODO добавить модуль lockable
  # 5й TODO добавить модуль OMNIAUTH
  before_action :admin_permission, except: [:new, :create, :update,:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).order(:login)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @current_user
        redirect_to @user, notice: 'Пользователь создан.'
      else
        @user.force_authenticate!(self)
        redirect_to @user, notice: 'Регистрация завершена.'
      end
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Пользователь изменен.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Пользователь успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def registration_params
    params.require(:user).permit(:login, :password, :sex, :birthday, :email, :avatar, :country_id, :team_country_id)
  end

  def user_params
    attrs = [:login, :password, :sex, :birthday, :email, :avatar, :country_id]
    attrs << :role if @current_user.try(:admin?)
    params.require(:user).permit(*attrs)
  end
end
