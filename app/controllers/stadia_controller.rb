class StadiaController < ApplicationController
  before_action :set_stadium, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: :new
  before_action :admin_permission, only: [:destroy, :index]

  def index
    @stadia = Stadium.all
  end

  def show
    @team = @stadium.team
    @user = @team.user
  end

  def new
    @stadium = Stadium.new
  end

  # TODO посмотреть что это
  def edit
    old_level=@stadium.level
    if !params[:level].blank? && !params[:level].blank? && params[:level].to_i != old_level
      lvl=params[:level].to_i
      if lvl!=old_level+1
        flash[:danger]='Неправильный параметр уровня стадиона!'
        redirect_to @stadium
      elsif lvl>5
        flash[:danger]='Ваш стадион имеет максимальный уровень!'
        redirect_to @stadium
      else
        if old_level==1
          cost=200000
        elsif old_level==2
          cost=500000
        elsif old_level==3
          cost=1000000
        elsif old_level==4
          cost=2500000
        else
          flash[:danger]='Неправильное значение уровня стадиона!'
          redirect_to @stadium
        end
        team=Team.find(@stadium.team_id)
        if team.budget-cost<0
          flash[:danger]='На вашем счету недостаточно средств для улучшения стадиона!'
          redirect_to @stadium
        else
          team.budget-=cost
          team.save!
          @stadium.update(level:lvl)
          redirect_to @stadium, notice: 'Уровень стадиона успешно повышен.'
        end
      end
    else
      redirect_to @stadium
    end
  end

  def create
    hash = params
    other_hash = {"stadium"=>params[:stadium]}
    stadium_params.delete(hash.keys[0])
    stadium_params.update(other_hash)
    @stadium = Stadium.new(stadium_params)
    @team = Team.find(stadium_params[:team_id]) #TODO переделать на @current_user_team
    @stadium.team_id = @team.id
    @stadium.capacity = 200
    @stadium.level = 1
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

  def update
    old_cap=@stadium.capacity
    cp=params[:stadium][:capacity]
    cpi=cp.to_i
    if cpi<old_cap
      flash[:danger]='Новое значение стадиона не может быть меньше предыдущего!'
      redirect_to @stadium
    elsif cp.size>6
      flash[:danger]='Вы ввели слишком большое число!'
      redirect_to @stadium
    elsif cpi
      r,lvl=cpi-old_cap,@stadium.level
      if cpi>1000 && lvl==1 || cpi>5000 && lvl==2 || cpi>20000 && lvl==3 || cpi>50000 && lvl==4
        flash[:danger]='Слишком низкий уровень стадиона для постройки новых мест!'
        redirect_to @stadium
      else
        if lvl==1
          cost=r*500
        elsif lvl==2
          cost=r*400
        elsif lvl==3
          cost=r*300
        elsif lvl==4
          cost=r*200
        elsif lvl==5
          cost=r*100
        else
          flash[:danger]='Не удалось изменить вместительность стадиона! Что-то пошло не так!'
          redirect_to @stadium
        end
        team=Team.find(@stadium.team_id)
        if team.budget-cost<0
          flash[:danger]='На вашем счету недостаточно средств для модернизации стадиона!'
          redirect_to @stadium
        else
          team.budget-=cost
          team.save!
          @stadium.update(capacity:cpi)
          redirect_to @stadium, notice: 'Стадион успешно модернизирован.'
        end
      end
    else
      if @stadium.update(stadium_params)
        redirect_to @stadium, notice: 'Стадион успешно изменён.'
      else
        render :edit
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

  def set_team
    @team = Team.find(params[:team_id])
  end
  
  def stadium_params
    params.require(:stadium).permit(:title,:team_id)#, :capacity, :level, :team_id)
  end
end
