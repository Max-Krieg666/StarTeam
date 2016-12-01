class ClubBasesController < ApplicationController
  before_action :set_club_base, except: [:new, :create]
  before_action :set_team, only: [:new]
  before_action :admin_permission, only: :destroy

  def show
    @team = @club_base.team
    @user = @team.user
  end

  def new
    @club_base = ClubBase.new
  end

  def edit
    # todo изменение названия базы
  end

  def level_up
    team = @club_base.team
    # увеличение уровня базы клуба
    if @club_base.level == 5
      flash[:danger] = 'База клуба имеет максимальный уровень!'
      redirect_to @club_base
    else
      values = ClubBase::LEVELS[@club_base.level]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = 'На вашем счету недостаточно средств для улучшения базы клуба!'
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
        redirect_to @club_base, notice: 'Уровень базы клуба успешно повышен.'
      end 
    end
  end

  def training_fields_up
    team = @club_base.team
    # увеличение к-во тренировочных полей
    if @club_base.training_fields == 5
      flash[:danger] = 'Максимальное количество тренировочных полей достигнуто!'
      redirect_to @club_base
    else
      values = ClubBase::TRAINING_FIELDS[@club_base.training_fields]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = 'На вашем счету недостаточно средств для постройик нового тренировочного поля!'
        redirect_to @club_base
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          @club_base.training_fields += 1
          @club_base.experience_up += values[1]
          @club_base.save!
        end
        redirect_to @club_base, notice: 'Построено новое тренировочное поле.'
      end
    end
  end

  def create
    @club_base = ClubBase.new(club_base_params)
    @club_base.team_id = @current_user_team.id
    if @club_base.save
      redirect_to @club_base, notice: 'База успешно создана.'
    else
      render :new
    end
  end

  def update
    if @club_base.update(club_base_params)
      redirect_to @club_base, notice: 'База успешно изменена.'
    else
      render :edit
    end
  end

  def destroy
    @club_base.destroy
    redirect_to club_bases_url, notice: 'База успешно удалена.'
  end

  private
  
  def set_club_base
    @club_base = ClubBase.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def club_base_params
    params.require(:club_base).permit(:title)#:level, :capacity, :training_fields, :experience_up, :team_id)
  end
end
