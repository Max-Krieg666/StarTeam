class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :random_players]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.order("title")
  end

  def random_players #тут метод беспощадного рандома игроков
    pit=PlayerInTeam.where(team_id:@team.id,none: false).to_a
    if pit.size>0 && params[:random].blank?
      flash[:danger]='Невозможно рандомизировать состав'
      redirect_to @team
    else
      #для укомплектования состава выбераем 18 игроков - 11 основа + 7 запас
      #2 Gk + 2 Ld + 3 Cd +2 Rd + 1 Lm + 3 Cm + 2 Rm + 1 Lf + 1 Cf + 1 Rf
      #основа: gk,ld,2cd,rd,lm,2cm,rm,cf,rf
      gks=Player.where(position1: "Gk").to_a
      lds=Player.where(position1: "Ld").to_a
      cds=Player.where(position1: "Cd").to_a
      rds=Player.where(position1: "Rd").to_a
      lms=Player.where(position1: "Lm").to_a
      cms=Player.where(position1: "Cm").to_a
      rms=Player.where(position1: "Rm").to_a
      lfs=Player.where(position1: "Lf").to_a
      cfs=Player.where(position1: "Cf").to_a
      rfs=Player.where(position1: "Rf").to_a
      x=another([],gks,lds,cds,rds,lms,cms,rms,lfs,cfs,rfs)
      cost,line_up=x[0],x[1]
      while cost>@team.budget
        x=another(line_up,gks,lds,cds,rds,lms,cms,rms,lfs,cfs,rfs)
        cost,line_up=x[0],x[1]
      end
      for i in 0...line_up.size
        pl=line_up[i]
        pla=PlayerInTeam.where(team_id: 0, name: pl.name,none:true).first
        if pla
          if @team.budget<pla.price
            flash[:danger]='На счету Вашей команды недостаточно средств для покупки данного игрока!'
            redirect_to players_path
          else
            if pl.update(inteam:true)
              if @team.update!(budget: @team.budget-pl.price)
                pls=PlayerInTeam.where(team_id:@team.id).map{|x| x.number}
                pla.number=num(pls)
                pla.team_id=@team.id
                pla.basic=false
                pla.none=false
                if !(pla.save!)
                  flash[:danger]='Не удалось обновить team_id!'
                  redirect_to players_path
                end
              else
                flash[:danger]='Ошибка в бюджете!'
                redirect_to players_path
              end
            else
              flash[:danger]='Действие не удалось!'
              redirect_to players_path
            end
          end
        else
          if @team.update(budget: @team.budget-pl.price)
            a=PlayerInTeam.new
            a.name=pl.name
            a.team_id=@team.id
            a.position1=pl.position1
            a.position2=pl.position2
            a.country_id=pl.country_id
            a.position1=pl.position1
            a.position2=pl.position2
            a.talent=pl.talent
            a.pos=right_alph_srt(pl.position1)
            a.age=pl.age
            a.skill_level=pl.skill_level
            a.price=pl.price
            a.basic=false
            a.status='active'
            plrs=PlayerInTeam.where(team_id:@team.id).order("price desc").first
            if plrs
              if plrs.price<pl.price
                a.captain=true
                plrs.update(captain:false)
              end
            end
            if a.save
              pl.update(inteam:true)
            else
              flash[:danger]='Не получилось обновить игрока!'
              redirect_to @team
            end
          else
            flash[:danger]='Что-то пошло не так!'
            redirect_to @team
          end
        end
      end
      t=@team.player_in_teams.to_a
      for i in 0...t.size
        pls=PlayerInTeam.where(team_id:@team.id).map{|x| x.number}.compact!
        t[i].number=num(pls)
        if t[i].position1!='Cm' || t[i].position1!='Cd'
          if t[i].id==PlayerInTeam.where(team_id:@team.id,position1:t[i].position1).order("skill_level desc").first.id
            t[i].basic=true
          end
        else
          crs=PlayerInTeam.where(team_id:@team.id,position1:t[i].position1).order("skill_level desc").limit(2).to_a
          if t[i].id==crs[0].id || t[i].id==crs[1].id
            t[i].basic=true
          end
        end
        t[i].save!
      end
      redirect_to @team, notice: 'Команда успешно укомплектована.'
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @players=PlayerInTeam.where(team_id:@team.id, none:false).order(basic: :desc,pos: :asc,skill_level: :desc).to_a
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.user_id=@current_user.id
    @team.budget=2000000.0
    @team.fans=50
    respond_to do |format|
      if @team.save
        sp=Sponsor.find(@team.sponsor_id)
        sp.team_id=@team.id
        sp.save!
        @current_user.team_id=@team.id
        @current_user.team=@team
        @current_user.save!
        format.html { redirect_to @team, notice: 'Команда успешно создана.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
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

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    sp_id=@team.sponsor_id
    @team.destroy
    sp=Sponsor.find(sp_id)
    sp.team_id=nil
    sp.save!
    respond_to do |format|
      format.html { redirect_to @current_user, notice: 'Команда удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

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
      while mas.include?(n)
        n=rand(99)+1
      end
      return n
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      attrs=[:title, :sponsor_id]
      attrs << :budget if @current_user.try(:admin?)
      attrs << :fans if @current_user.try(:admin?)
      params.require(:user).permit(*attrs)
    end
end
