class TeamsController < ApplicationController
  include Definer
  before_action :set_team, except: [:new, :create, :destroy]
  before_action :check_user

  def index
    @teams = Team.order('title')
  end

  def show
    @players = @team.players.order('basic asc, position1 asc, skill_level desc')
    @club_base = @team.club_base ? @team.club_base : nil
    @stadium = @team.stadium
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = @current_user.id
    @team.budget = 2000000.0
    @team.fans = 50
    respond_to do |format|
      if @team.save
        sp = Sponsor.find(@team.sponsor.id)
        sp.team_id = @team.id
        sp.save!
        @current_user.team_id = @team.id
        @current_user.team = @team
        @current_user.save!
        format.html { redirect_to @team, notice: 'Команда успешно создана.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Команда изменена.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sp = @team.sponsor
    @team.destroy
    sp.team_id = nil
    sp.save!
    # TODO при удалении команды отпускать на свободный рынок всех игроков в ней
    respond_to do |format|
      format.html { redirect_to @current_user, notice: 'Команда удалена.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_team
    @team = Team.find(params[:id])
  end
  # TODO разобраться с этими стрёмными методами
  def my_rand(mas,how)
    a,x=[],0
    while x!=how
      (how-x).times do
        z=rand(mas.size)
        if mas[z].price<210000
          a<<z
          x+=1
        end
      end
      a.uniq!
      x=a.size
    end
    return a
  end
  
  def func(ind,pos,line)
    for i in 0...ind.size
      line<<pos[ind[i]]
    end
  end

  def another(line_up,gks,lds,cds,rds,lms,cms,rms,lfs,cfs,rfs)
    cost=0
    func(my_rand(gks,2),gks,line_up)
    func(my_rand(lds,2),lds,line_up)
    func(my_rand(cds,3),cds,line_up)
    func(my_rand(rds,2),rds,line_up)
    func(my_rand(lms,1),lms,line_up)
    func(my_rand(cms,3),cms,line_up)
    func(my_rand(rms,2),rms,line_up)
    func(my_rand(lfs,1),lfs,line_up)
    func(my_rand(cfs,1),cfs,line_up)
    func(my_rand(rfs,1),rfs,line_up)
    for k in 0...line_up.size
      cost+=line_up[k].price
    end
    return [cost.round(3),line_up]
  end

  def num(mas)
    n=rand(99)+1
    if !(mas.blank?)
      while mas.include?(n)
        n=rand(99)+1
      end
    end
    return n
  end

  def team_params
    attrs = [:title, :sponsor]
    if @current_user.try(:admin?)
      attrs += [:budget, :fans]
    end
    params.require(:team).permit(*attrs)
  end
end
