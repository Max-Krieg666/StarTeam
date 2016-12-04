class StadiaController < ApplicationController
  before_action :set_stadium, except: [:create, :new]
  before_action :admin_permission, only: [:destroy]

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
      redirect_to @stadium, notice: 'Название стадиона успешно изменено.'
    else
      render :edit
    end
  end

  def create
    @stadium = Stadium.new(stadium_params)
    @stadium.team_id = @current_user_team.id
    respond_to do |format|
      if @stadium.save
        format.html { redirect_to @stadium, notice: 'Стадион успешно создан.' }
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
      flash[:danger] = 'Ваш стадион имеет максимальный уровень!'
      redirect_to @stadium
    else
      values = Stadium::LEVELS[@stadium.level + 1]
      if team.budget - values[0] < 0 # цена больше бюджета
        flash[:danger] = 'На вашем счету недостаточно средств для стадиона! Необходимо: ' + values[0].to_s
        redirect_to @stadium
      else
        ActiveRecord::Base.transaction do
          team.budget -= values[0]
          team.save!
          @stadium.level += 1
          @stadium.save!
        end
        redirect_to @stadium, notice: 'Уровень стадиона успешно повышен.'
      end 
    end
  end

  def capacity_up
    new_capacity = capacity_params[:capacity].to_i
    if @stadium.capacity > new_capacity
      flash[:danger] = 'Новое значение вместительности не может быть меньше предыдущего!'
      redirect_to @stadium
    elsif @stadium.max_capacity < new_capacity
      flash[:danger] = 'Прежде, чем увеличивать вместительность, необходимо увеличить уровень стадиона!'
      redirect_to @stadium
    elsif @stadium.capacity == 100000 && @stadium.level == 5
      flash[:danger] = 'Максимальная вместительность достигнута!'
      redirect_to @stadium
    else
      difference = new_capacity - @stadium.capacity
      cost = difference * Stadium::LEVELS[@stadium.level][3]
      team = @stadium.team
      if team.budget - cost < 0
        flash[:danger] = 'На вашем счету недостаточно средств для модернизации стадиона!'
        redirect_to @stadium
      else
        ActiveRecord::Base.transaction do
          team.budget -= cost
          team.save!
          @stadium.update(capacity: new_capacity)
        end
        redirect_to @stadium, notice: 'Стадион успешно модернизирован.'
      end
    end
  end

  def destroy
    @stadium.destroy
    respond_to do |format|
      format.html { redirect_to stadia_url, notice: 'Стадион удалён.' }
      format.json { head :no_content }
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
