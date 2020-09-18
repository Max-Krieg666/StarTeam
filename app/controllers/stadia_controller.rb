class StadiaController < ApplicationController
  before_action :check_user
  before_action :set_stadium, except: [:create, :new]

  def show
    @team = @stadium.team
    @user = @team.user
  end

  def new
    @stadium = Stadium.new
    @team = @current_user_team
  end

  def edit
    @team = @current_user_team
  end

  def update
    @team = @current_user_team
    if @stadium.update(stadium_params)
      redirect_to [@team, @stadium], notice: I18n.t('flash.stadiums.title_changed')
    else
      render :edit
    end
  end

  def create
    @stadium = Stadium.new(stadium_params)
    @team = @current_user_team
    @stadium.team_id = @team.id
    respond_to do |format|
      if @stadium.save
        format.html { redirect_to [@team, @stadium], notice: I18n.t('flash.stadiums.created') }
        format.json { render :show, status: :created, location: @stadium }
      else
        format.html { render :new }
        format.json { render json: @stadium.errors, status: :unprocessable_entity }
      end
    end
  end

  def level_up
    team = @stadium.team
    # увеличение уровня стадиона
    if @stadium.max_level?
      flash[:danger] = I18n.t('flash.stadiums.max_level')
    else
      values = Stadium::LEVELS[@stadium.level + 1]
      if team.low_budget?(values[0]) # цена больше бюджета
        flash[:danger] = I18n.t('flash.stadiums.not_enough_money') + values[0].to_s
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          team.operations.create(
            sum: values[0],
            kind: false,
            title: I18n.t('messages.operation.modernization_stadium')
          )
          @stadium.level += 1
          @stadium.save!
        end
        flash[:notice] = I18n.t('flash.stadiums.upgraded')
      end
    end

    redirect_to [team, @stadium]
  end

  def capacity_up
    new_capacity = capacity_params[:capacity].to_i
    team = @stadium.team
    if @stadium.low_capacity?(new_capacity)
      flash[:danger] = I18n.t('flash.stadiums.low_capacity')
    elsif @stadium.low_level?(new_capacity)
      flash[:danger] = I18n.t('flash.stadiums.low_level')
    elsif @stadium.max_capacity?
      flash[:danger] = I18n.t('flash.stadiums.max_capacity')
    else
      difference = new_capacity - @stadium.capacity
      cost = difference * Stadium::LEVELS[@stadium.level][3]
      if team.low_budget?(cost)
        flash[:danger] = I18n.t('flash.stadiums.not_enough_money') + cost.to_s
      else
        ActiveRecord::Base.transaction do
          team.budget -= cost
          team.save!
          team.operations.create(
            sum: cost,
            kind: false,
            title: I18n.t('messages.operation.new_seats_on_stadium')
          )
          @stadium.update(capacity: new_capacity)
        end
        flash[:notice] = I18n.t('flash.stadiums.upgraded')
      end
    end

    redirect_to [team, @stadium]
  end

  private

  def set_stadium
    @stadium = Stadium.find(params[:id])
  end

  def stadium_params
    params.require(:stadium).permit(:title)
  end

  def capacity_params
    params.require(:stadium).permit(:capacity)
  end
end
