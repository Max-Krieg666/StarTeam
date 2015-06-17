class PlayerInTeamsController < ApplicationController
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
    @player_in_team = PlayerInTeam.new
  end

  # GET /player_in_teams/1/edit
  def edit
  end

  # POST /player_in_teams
  # POST /player_in_teams.json
  def create
    agent=Player.where(name: params[:player_in_team][:name]).first
    team=Team.find(@current_user.team_id)
    if !team
      flash[:danger]='Прежде, чем покупать игроков, создайте команду!'
      redirect_to @current_user
    elsif team.budget<agent.price
      flash[:danger]='На счету Вашей команды недостаточно средств для покупки данного игрока!'
      redirect_to players_path
    else
      str=1
      if agent.position1=='Gk' && params[:player_in_team][:basic]=='true'
        player=PlayerInTeam.where(team_id: team.id, position1:'Gk').first
        if player
          player.basic=false
          if player.save!
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
        p=PlayerInTeam.where(team_id:3).order("price desc").first
        @player_in_team.captain=(p && p.price<agent.price)
        respond_to do |format|
          if @player_in_team.save
            team.budget-=@player_in_team.price
            team.save!
            agent.destroy!
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
    agent=Player.new
    agent.name=pl.name
    agent.country_id=pl.country_id
    agent.position1=pl.position1
    agent.position2=pl.position2
    agent.talent=pl.talent
    agent.age=pl.age
    agent.skill_level=pl.skill_level
    agent.price=(pl.talent*10000.0*pl.skill_level/pl.age).round(3)
    if pl.position1=='Gk' && pl.basic
      gks,i=PlayerInTeam.where(team_id: team.id, position1:'Gk').to_a,0
      while i<gks.size
        if gks[i].id!=pl.id
          player=gks[i];i=gks.size
        end
        i+=1
      end
      if !player
        player=pl
      end
      if player.update(basic:true)
        if agent.save!
          team.update(budget:team.budget+pl.price/2.0)
          @player_in_team.destroy
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
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_in_team
      @player_in_team = PlayerInTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_in_team_params
      #params.require(:player_in_team).permit(:special_skill1, :num_sp_s1, :special_skill2, :num_sp_s2, :special_skill3, :num_sp_s3, :number, :season_games, :all_games, :season_goals, :all_goals, :season_autogoals, :all_autogoals, :season_yellow_cards, :all_yellow_cards, :season_red_cards, :all_red_cards, :status, :can_play, :injured)
      params.require(:player_in_team).permit(:number, :team_id, :basic)
    end
end
