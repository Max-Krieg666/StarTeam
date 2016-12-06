class ClubBasesController < ApplicationController
  before_action :set_club_base, except: [:new, :create]
  # before_action :admin_permission, only: :destroy

  def show
    @team = @club_base.team
    @user = @team.user
  end

  def new
    @club_base = ClubBase.new
  end

  def edit
  end

  def level_up
    team = @club_base.team
    # увеличение уровня базы клуба
    if @club_base.level == 5
      flash[:danger] = I18n.t('flash.bases.maximum_level')
      redirect_to @club_base
    else
      values = ClubBase::LEVELS[@club_base.level]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = I18n.t('flash.bases.not_enough_money')
        redirect_to @club_base
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          @club_base.level += 1
          @club_base.experience_up += values[1]
          @club_base.capacity = values[2]
          @club_base.save!
        end
        redirect_to @club_base, notice: I18n.t('flash.bases.upgraded')
      end
    end
  end

  def training_fields_up
    team = @club_base.team
    # увеличение к-во тренировочных полей
    if @club_base.training_fields == 5
      flash[:danger] = I18n.t('flash.bases.maximum_training_fields')
      redirect_to @club_base
    else
      values = ClubBase::TRAINING_FIELDS[@club_base.training_fields]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = I18n.t('flash.bases.not_enough_money')
        redirect_to @club_base
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          @club_base.training_fields += 1
          @club_base.experience_up += values[1]
          @club_base.save!
        end
        redirect_to @club_base, notice: I18n.t('flash.bases.upgraded')
      end
    end
  end

  def create
    @club_base = ClubBase.new(club_base_params)
    @club_base.team_id = @current_user_team.id
    if @club_base.save
      redirect_to @club_base, notice: I18n.t('flash.bases.created')
    else
      render :new
    end
  end

  def update
    if @club_base.update(club_base_params)
      redirect_to @club_base, notice: I18n.t('flash.bases.title_was_edited')
    else
      render :edit
    end
  end

  def destroy
    @club_base.destroy
    redirect_to club_bases_url, notice: I18n.t('flash.bases.destroyed')
  end

  private
  
  def set_club_base
    @club_base = ClubBase.find(params[:id])
  end

  def club_base_params
    params.require(:club_base).permit(:title)
  end
end
