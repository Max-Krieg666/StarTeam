class PlayerInTeamsController < ApplicationController
  include Definer
  before_action :set_player_in_team, only: [:show, :edit, :update, :destroy]
  before_action :admin_permission, only: [:index]
  # GET /player_in_teams
  # GET /player_in_teams.json
  def index
    @player_in_teams = PlayerInTeam.all
  end

  # GET /player_in_teams/1
  # GET /player_in_teams/1.json
  def show
  end

  # GET /player_in_teams/new
  def new
    if params[:name]
      @player_in_team = PlayerInTeam.new
    else
      @player_in_team = PlayerInTeam.new(name:params[:name])
    end
  end

  # GET /player_in_teams/1/edit
  def edit
  end

  # POST /player_in_teams
  # POST /player_in_teams.json
  def create
    team=Team.find(@current_user.team_id)
    cb=ClubBase.find(team.club_basis_id)
    nam=params[:name] if params[:name]
    nam=params[:player_in_team][:name] if params[:player_in_team][:name]
    agent=Player.where(name: nam).first
    pl_it=PlayerInTeam.where(name:nam,team_id:0,none:true).first
    if !team
      flash[:danger]='Прежде, чем покупать игроков, создайте команду!'
      redirect_to new_team_path
    elsif cb.capacity==PlayerInTeam.where(team_id:team.id).to_a.size
      flash[:danger]='Расширьте базу клуба для покупки новых игроков!'
      redirect_to cb
    else
      if !agent.blank? && pl_it.blank?
        if team.budget<agent.price
          flash[:danger]='На счету Вашей команды недостаточно средств для покупки данного игрока!'
          redirect_to players_path
        else
          str=1
          player=PlayerInTeam.where(team_id: team.id, position1:agent.position1).first
          if params[:player_in_team][:basic]=='true'
            if player
              if player.position1!='Cm' || player.position1!='Cd'
                k=PlayerInTeam.where(team_id:team.id,position1:player.position1).order("skill_level desc").first
                if !k
                  player.basic=true
                elsif player.skill_level>k.skill_level
                  player.basic=true
                  k.update(basic:false)
                else
                  player.basic=false
                end
              else
                crs=PlayerInTeam.where(team_id:team.id,position1:player.position1).order("skill_level desc").limit(2).to_a
                if crs.size<2
                  player.basic=true
                elsif player.skill_level>crs[0].skill_level || player.skill_level>crs[1].skill_level
                  player.basic=true
                  crs[1].update(basic:false)
                else
                  player.basic=false
                end
              end
              if player.save
                str=2
              else
                str=3
              end
            end
          end
          if str!=3
            @player_in_team=PlayerInTeam.new
            @player_in_team.name=agent.name
            @player_in_team.country_id=agent.country_id
            @player_in_team.position1=agent.position1
            @player_in_team.position2=agent.position2
            @player_in_team.pos=right_alph_srt(agent.position1)
            @player_in_team.talent=agent.talent
            @player_in_team.age=agent.age
            @player_in_team.skill_level=agent.skill_level
            @player_in_team.price=agent.price
            @player_in_team.team_id=team.id
            @player_in_team.basic=(params[:player_in_team][:basic]=='true')
            @player_in_team.number=params[:player_in_team][:number]
            @player_in_team.all_games=0
            @player_in_team.season_games=0
            @player_in_team.all_autogoals=0
            @player_in_team.season_autogoals=0
            @player_in_team.all_conceded_goals=0 if agent.position1=='Gk'
            @player_in_team.season_conceded_goals=0 if agent.position1=='Gk'
            @player_in_team.all_goals=0
            @player_in_team.season_goals=0
            @player_in_team.season_passes=0
            @player_in_team.all_passes=0
            @player_in_team.all_yellow_cards=0
            @player_in_team.season_yellow_cards=0
            @player_in_team.all_red_cards=0
            @player_in_team.season_red_cards=0
            @player_in_team.status='active'
            @player_in_team.can_play=true
            @player_in_team.games_missed=0
            @player_in_team.injured=0
            if @player_in_team.position1!='Cm' || @player_in_team.position1!='Cd'
              k=PlayerInTeam.where(team_id:team.id,position1:player.position1).order("skill_level desc").first
              if !k
                @player_in_team.basic=true
              elsif player.skill_level>k.skill_level
                @player_in_team.basic=true
                k.update(basic:false)
              else
                @player_in_team.basic=false
              end
            else
              crs=PlayerInTeam.where(team_id:team.id,position1:player.position1).order("skill_level desc").limit(2).to_a
              if crs.size<2
                @player_in_team.basic=true
              elsif @player_in_team.skill_level>crs[0].skill_level || @player_in_team.skill_level>crs[1].skill_level
                @player_in_team.basic=true
                crs[1].update(basic:false)
              else
                @player_in_team.basic=false
              end
            end
            p=PlayerInTeam.where(team_id:team.id, none: false).order("price desc").first
            @player_in_team.captain=(p && p.price<agent.price)
            respond_to do |format|
              if @player_in_team.save
                team.budget-=@player_in_team.price
                team.save!
                agent.update(in_team:true)
                format.html { redirect_to @player_in_team, notice: 'Игрок куплен.' }
                format.json { render :show, status: :created, location: @player_in_team }
              else
                format.html { render :new}
                format.json { render json: @player_in_team.errors, status: :unprocessable_entity }
              end
            end
          else
            flash[:danger]='Не удалось изменить статус игрока, попробуйте позже.'
            render :new
          end
        end
      elsif !pl_it.blank?
        if team.budget<agent.price
          flash[:danger]='На счету Вашей команды недостаточно средств для покупки данного игрока!'
          redirect_to players_path
        else
          pl_it.team_id=team.id
          pl_it.none=false
          pl_it.number=params[:player_in_team][:number] if params[:player_in_team][:number]
          agent.in_team=true
          team.budget-=pl_it.price
          team.save!
          agent.save!
          pl_it.save!
          redirect_to team, notice: 'Игрок куплен.'
        end
      else
        flash[:danger]='Не удалось купить игрока.'
        redirect_to team
      end
    end
  end

  # PATCH/PUT /player_in_teams/1
  # PATCH/PUT /player_in_teams/1.json
  def update
    respond_to do |format|
      if @player_in_team.update(player_in_team_params)
        format.html { redirect_to @player_in_team, notice: 'Номер игрока изменён.' }
        format.json { render :show, status: :ok, location: @player_in_team }
      else
        format.html { render :edit }
        format.json { render json: @player_in_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_in_teams/1
  # DELETE /player_in_teams/1.json
  def destroy
    pl=@player_in_team
    team=Team.find(@current_user.team_id)
    agent=Player.where(in_team:true,name:pl.name).first
    agent.price=(pl.talent*10000.0*pl.skill_level/pl.age).round(3)
    agent.price+=100000 if !pl.position2.blank?
    sum=0
    sum=pl.num_sp_s1 if pl.num_sp_s1
    sum+=pl.num_sp_s2 if pl.num_sp_s2
    sum+=pl.num_sp_s3 if pl.num_sp_s3
    agent.price+=25000*sum
    agent.in_team=false
    if pl.basic
      gks,i=PlayerInTeam.where(team_id: team.id, none: false, position1:'Gk').to_a,0
      while i<gks.size
        if gks[i].id!=pl.id
          player=gks[i];i=gks.size
        end
        i+=1
      end
      if pl.captain
        p=PlayerInTeam.where(team_id:team.id, none: false).order("price desc").limit(2).to_a
        if p.size>1
          if p[0].name==pl.name
            p[1].captain=true
            p[1].save!
          else
            p[0].captain=true
            p[0].save!
          end
        end
      end
    end
    if !player
      player=pl
    end
    if player.update(basic:true)
      if agent.save
        team.update(budget:team.budget+pl.price/2.0)
        @player_in_team.update(none:true,captain:false,team_id:0)
        respond_to do |format|
          format.html { redirect_to team, notice: 'Игрок уволен из Вашей команды и стал свободным агентом.' }
          format.json { head :no_content }
        end
      else
        flash[:danger]='Нельзя удалить игрока'
        redirect_to @player_in_team
      end
    else
      flash[:danger]='Не удалось изменить статус игрока, попробуйте позже.'
      render :new
    end


    #redirect_to team, notice: 'Игрок уволен из Вашей команды и стал свободным агентом.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_in_team
      @player_in_team = PlayerInTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_in_team_params
      #params.require(:player_in_team).permit(:special_skill1, :num_sp_s1, :special_skill2, :num_sp_s2, :special_skill3, :num_sp_s3, :number, :season_games, :all_games, :season_goals, :all_goals, :season_autogoals, :all_autogoals, :season_yellow_cards, :all_yellow_cards, :season_red_cards, :all_red_cards, :status, :can_play, :injured)
      params.require(:player_in_team).permit(:number, :team_id, :basic,:captain)
    end
end
