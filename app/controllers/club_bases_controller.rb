class ClubBasesController < ApplicationController
  before_action :check_user
  before_action :set_club_base, except: [:new, :create]

  def show
    @team = @club_base.team
    @user = @team.user
  end

  def new
    @club_base = ClubBase.new
    @team = @current_user_team
  end

  def edit
    @team = @club_base.team
  end

  def level_up
    team = @club_base.team
    # увеличение уровня базы клуба
    if @club_base.max_level?
      flash[:danger] = I18n.t('flash.bases.max_level')
      redirect_to [team, @club_base]
    else
      values = ClubBase::LEVELS[@club_base.level + 1]
      if team.low_budget?(values[0]) # цена больше бюджета
        flash[:danger] = I18n.t('flash.bases.not_enough_money')
        redirect_to [team, @club_base]
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          Operation.create(
            team_id: team.id, sum: values[0], kind: false,
            title: I18n.t('messages.operation.modernization_club_base')
          )
          @club_base.level += 1
          @club_base.experience_up += values[1]
          @club_base.capacity = values[2]
          @club_base.save!
        end
        redirect_to [team, @club_base], notice: I18n.t('flash.bases.upgraded')
      end
    end
  end

  def training_fields_up
    team = @club_base.team
    # увеличение к-во тренировочных полей
    if @club_base.max_training_fields?
      flash[:danger] = I18n.t('flash.bases.maximum_training_fields')
      redirect_to [team, @club_base]
    else
      values = ClubBase::TRAINING_FIELDS[@club_base.training_fields + 1]
      if team.low_budget?(values[0]) # цена больше бюджета
        flash[:danger] = I18n.t('flash.bases.not_enough_money')
        redirect_to [team, @club_base]
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          Operation.create(
            team_id: team.id, sum: values[0], kind: false,
            title: I18n.t('messages.operation.upgrade_fields_club_base')
          )
          @club_base.training_fields += 1
          @club_base.experience_up += values[1]
          @club_base.save!
        end
        redirect_to [team, @club_base], notice: I18n.t('flash.bases.upgraded')
      end
    end
  end

  def create
    @club_base = ClubBase.new(club_base_params)
    @team = @current_user_team
    @club_base.team_id = @team.id
    if @club_base.save
      redirect_to [@team, @club_base], notice: I18n.t('flash.bases.created')
    else
      render :new
    end
  end

  def update
    @team = @current_user_team
    if @club_base.update(club_base_params)
      redirect_to [@team, @club_base], notice: I18n.t('flash.bases.title_was_edited')
    else
      render :edit
    end
  end

  private
  def set_club_base
    @club_base = ClubBase.find(params[:id])
  end

  def club_base_params
    params.require(:club_base).permit(:title)
  end
end
