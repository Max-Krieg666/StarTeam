class StadiaController < ApplicationController
  before_action :check_user
  before_action :set_stadium, except: [:create, :new]

  def show
    @team = @stadium.team
    @user = @team.user
  end

  def new
    @stadium = Stadium.new
  end

  def edit
  end

  def update
    if @stadium.update(stadium_params)
      redirect_to @stadium, notice: I18n.t('flash.stadiums.title_changed')
    else
      render :edit
    end
  end

  def create
    @stadium = Stadium.new(stadium_params)
    @stadium.team_id = @current_user_team.id
    respond_to do |format|
      if @stadium.save
        format.html { redirect_to @stadium, notice: I18n.t('flash.stadiums.created') }
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
    if @stadium.level == 5
      flash[:danger] = I18n.t('flash.stadiums.max_level')
      redirect_to @stadium
    else
      values = Stadium::LEVELS[@stadium.level + 1]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = I18n.t('flash.stadiums.not_enough_money') + values[0].to_s
        redirect_to @stadium
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          Operation.create(team_id: team.id, sum: values[0], kind: false, title: 'Модернизация стадиона')
          @stadium.level += 1
          @stadium.save!
        end
        redirect_to @stadium, notice: I18n.t('flash.stadiums.upgraded')
      end 
    end
  end

  def capacity_up
    new_capacity = capacity_params[:capacity].to_i
    if @stadium.capacity > new_capacity
      flash[:danger] = I18n.t('flash.stadiums.low_capacity')
      redirect_to @stadium
    elsif @stadium.max_capacity < new_capacity
      flash[:danger] = I18n.t('flash.stadiums.low_level')
      redirect_to @stadium
    elsif @stadium.capacity == 100000 && @stadium.level == 5
      flash[:danger] = I18n.t('flash.stadiums.max_capacity')
      redirect_to @stadium
    else
      difference = new_capacity - @stadium.capacity
      cost = difference * Stadium::LEVELS[@stadium.level][3]
      team = @stadium.team
      if team.budget - cost < 0
        flash[:danger] = I18n.t('flash.stadiums.not_enough_money') + cost.to_s
        redirect_to @stadium
      else
        ActiveRecord::Base.transaction do
          team.budget -= cost
          team.save!
          Operation.create(team_id: team.id, sum: cost, kind: false, title: 'Строительство новых мест на стадионе')
          @stadium.update(capacity: new_capacity)
        end
        redirect_to @stadium, notice: I18n.t('flash.stadiums.upgraded')
      end
    end
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
