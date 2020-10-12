class UsersController < ApplicationController
  # TODO разобраться с отправкой на email писем Confirmable
  # TODO добавить модуль Recoverable собственноручный
  # TODO добавить модуль lockable
  # TODO добавить модуль OMNIAUTH
  before_action :check_user, except: [:registration, :create]
  before_action :admin_permission, only: [:index, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page]).order(:login)
  end

  def show
    @country = @user.country
  end

  def registration
    redirect_to @current_user if @current_user
    @user = User.new do |u|
      u.team = Team.new
    end
  end

  def confirmation
    u = User.where(confirmation_token: confirmation_params[:confirmation_token]).first
    if u && !u.confirmed_at.present?
      u.update!(confirmed_at: Time.current)
      redirect_to u, success: I18n.t('flash.users.account_confirmed')
    else
      redirect_to root_path, error: I18n.t('flash.users.invalid_confirmed_key')
    end
  end

  def edit; end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params.dup.except(:team_attributes))
      if @user.save
        team = CreateNewTeamService.perform(@user, team_params)

        # ОТПРАВКА СООБЩЕНИЯ
        # TODO: refactor -> JOB
        # NOTE: TEMPORARY STUB
        # ConfirmationMailer.send_confirmation(@user, team).deliver_later
        session[:user_id] = @user.id
        @user.authenticate(user_params[:password])
        redirect_to @user, success: I18n.t('flash.users.registration_completed')
      else
        render :registration, params: params
      end
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: I18n.t('flash.users.edited')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, success: I18n.t('flash.users.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    attrs = [
      :login, :email,
      :password, :password_confirmation, :country_id,
      :avatar, :sex, :birthday,
      team_attributes: %i[title country_id]
    ]
    attrs << :role if @current_user&.admin?
    params.require(:user).permit(*attrs)
  end

  def team_params
    params.require(:user).permit(
      team_attributes: %i[title country_id]
    )
  end

  def confirmation_params
    params.require(:user).permit(:confirmation_token)
  end
end
