class UsersController < ApplicationController
  #TODO подумать об отдельных методах на восстановление пароля, регистрацию и т.д.
  # 2й TODO разобраться с отправкой на email писем Confirmable
  # 3й TODO добавить модуль Recoverable собственноручный
  # 4й TODO добавить модуль lockable
  # 5й TODO добавить модуль OMNIAUTH
  before_action :admin_permission, except: [:new, :create, :update, :show, :registration]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).order(:login)
  end

  def show
  end

  def registration
    @user = User.new
  end

  def confirmation
    u = @user.where(confirmation_token: confirmation_params[:confirmation_token]).first
    if u && u.confirmed_at.present?
      u.update!(confirmed_at: DateTime.current)
      redirect_to u, notice: 'Вы успешно подтвердили свой аккаунт!'
    else
      redirect_to root_path, error: 'Ключ подтверждения невалиден!'
    end
  end

  def edit
  end

  def create
    # не работает если sex = 2..................
    # TODO ActiveRecord::Base.transaction ???
    @user = User.new(user_params)
    @user.confirmation_sent_at = DateTime.current
    @user.confirmation_token = SecureRandom.uuid
    @team = Team.new(team_params)
    # @team.sponsor = Sponsor.create_rand
    if @user.save && @team.save
      RandomTeam.new(@team)
      if @current_user
        redirect_to @user, notice: 'Пользователь создан.'
      else
        # ОТПРАВКА СООБЩЕНИЯ
        ConfirmationMailer.send_confirmation(@user, @team).deliver_later
        @user.force_authenticate!(self)
        redirect_to @user, notice: 'Регистрация завершена.'
      end
    else
      render :registration
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Пользователь изменён.'
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

  def user_params
    attrs = [:login, :password, :sex, :birthday, :email, :avatar, :country_id]
    attrs << :role if @current_user.try(:admin?)
    params.require(:user).permit(*attrs)
  end

  def confirmation_params
    params.require(:user).permit(:confirmation_token)
  end

  def team_params
    params.require(:team).permit(:title, :country_id)
  end
end
