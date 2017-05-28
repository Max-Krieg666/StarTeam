class UsersController < ApplicationController
  # TODO подумать об отдельных методах на восстановление пароля, регистрацию и т.д.
  # 2й TODO разобраться с отправкой на email писем Confirmable
  # 3й TODO добавить модуль Recoverable собственноручный
  # 4й TODO добавить модуль lockable
  # 5й TODO добавить модуль OMNIAUTH
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
    @user = User.new
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
    # НЕАДЕКВАТНО РАБОТАЕТ если пользователь не ввел поля
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)
      @user.confirmation_sent_at = DateTime.current
      @user.confirmation_token = SecureRandom.uuid
      if @user.save
        @team = Team.new(team_params)
        @team.user_id = @user.id
        if @team.save
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
            @user.force_authenticate!(self)
            redirect_to @user, notice: I18n.t('flash.users.registration_completed')
          end
        else
          render :registration, notice: I18n.t('flash.teams.not_filled_fields')
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
    attrs = [:login, :password, :sex, :birthday, :email, :avatar, :country_id, :password_confirmation]
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
