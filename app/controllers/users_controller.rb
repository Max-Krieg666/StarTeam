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
      u.update!(confirmed_at: DateTime.current)
      redirect_to u, notice: I18n.t('flash.users.account_confirmed')
    else
      redirect_to root_path, error: I18n.t('flash.users.invalid_confirmed_key')
    end
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)
      @user.confirmation_sent_at = DateTime.current
      @user.confirmation_token = SecureRandom.uuid
      if @user.save
        @team = @user.team
        Operation.create(team_id: @team.id, sum: 250000.0, kind: true, title: I18n.t('messages.operation.init'))
        Sponsor.create_rand(@team.id)
        Generator::RandomTeam.new(@team).generate
        @team.captain.update(captain: true)
        if @current_user && @current_user.administrator?
          redirect_to @user, notice: I18n.t('flash.users.created')
        else
          # ОТПРАВКА СООБЩЕНИЯ
          # todo JOB
          ConfirmationMailer.send_confirmation(@user, @team).deliver_later
          session[:user_id] = @user.id
          @user.authenticate(user_params[:password])
          redirect_to @user, notice: I18n.t('flash.users.registration_completed')
        end
      else
        render :registration
      end
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('flash.users.edited')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: I18n.t('flash.users.destroyed') }
      format.json { head :no_content }
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    attrs = [
      :login, :password, :sex,
      :birthday, :email, :avatar,
      :country_id, :password_confirmation,
      team_attributes: [
        :title, :country_id
      ]
    ]
    attrs << :role if @current_user.try(:admin?)
    params.require(:user).permit(*attrs)
  end

  def confirmation_params
    params.require(:user).permit(:confirmation_token)
  end
end
