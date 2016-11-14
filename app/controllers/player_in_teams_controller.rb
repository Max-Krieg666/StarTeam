class PlayerInTeamsController < ApplicationController
  include Definer
  before_action :set_player_in_team, only: [:show, :edit, :update, :destroy]
  before_action :admin_permission, only: [:index]

  def index
    @player_in_teams = Player.all
  end

  def show
  end

  def new
    if params[:name]
      @player_in_team = Player.new
    else
      @player_in_team = Player.new(name:params[:name])
    end
  end

  def edit
  end

  # def create
  #   team=Team.find(@current_user.team_id)
  #   cb=team.club_basis
  #   nam=params[:name] if params[:name]
  #   nam=params[:player_in_team][:name] if params[:player_in_team][:name]
  #   agent=Player.where(name: nam).first
  #   pl_it=Player.where(name:nam,team_id:0,none:true).first
  #   if !team
  #     flash[:danger]='Прежде, чем покупать игроков, создайте команду!'
  #     redirect_to new_team_path
  #   elsif cb.capacity==Player.where(team_id:team.id).to_a.size
  #     flash[:danger]='Расширьте базу клуба для покупки новых игроков!'
  #     redirect_to cb
  #   else
  #     if !agent.blank? && pl_it.blank?
  #       if team.budget<agent.price
  #         flash[:danger]='На счету Вашей команды недостаточно средств для покупки данного игрока!'
  #         redirect_to players_path
  #       else
  #         str=1
  #         player=Player.where(team_id: team.id, position1:agent.position1).first
  #         if params[:player_in_team][:basic]=='true'
            if player
              if player.position1!='Cm' || player.position1!='Cd'
                k=Player.where(team_id:team.id,position1:player.position1).order("skill_level desc").first
                if !k
                  player.basic=true
                elsif player.skill_level>k.skill_level
                  player.basic=true
                  k.update(basic:false)
                else
                  player.basic=false
                end
              else
                crs=Player.where(team_id:team.id,position1:player.position1).order("skill_level desc").limit(2).to_a
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
            # @player_in_team=Player.new
            # @player_in_team.name=agent.name
            # @player_in_team.country_id=agent.country_id
            # @player_in_team.position1=agent.position1
            # @player_in_team.position2=agent.position2
            # @player_in_team.pos=right_alph_srt(agent.position1)
            # @player_in_team.talent=agent.talent
            # @player_in_team.age=agent.age
            # @player_in_team.skill_level=agent.skill_level
            # @player_in_team.price=agent.price
            # @player_in_team.team_id=team.id
            # @player_in_team.basic=(params[:player_in_team][:basic]=='true')
            # @player_in_team.number=params[:player_in_team][:number]
            # @player_in_team.all_games=0
            # @player_in_team.season_games=0
            # @player_in_team.all_autogoals=0
            # @player_in_team.season_autogoals=0
            # @player_in_team.all_conceded_goals=0 if agent.position1=='Gk'
            # @player_in_team.season_conceded_goals=0 if agent.position1=='Gk'
            # @player_in_team.all_goals=0
            # @player_in_team.season_goals=0
            # @player_in_team.season_passes=0
            # @player_in_team.all_passes=0
            # @player_in_team.all_yellow_cards=0
            # @player_in_team.season_yellow_cards=0
            # @player_in_team.all_red_cards=0
            # @player_in_team.season_red_cards=0
            # @player_in_team.status='active'
            # @player_in_team.can_play=true
            # @player_in_team.games_missed=0
            # @player_in_team.injured=0
            if @player_in_team.position1!='Cm' || @player_in_team.position1!='Cd'
              k=Player.where(team_id:team.id,position1:player.position1).order("skill_level desc").first
              if !k
                @player_in_team.basic=true
              elsif player.skill_level>k.skill_level
                @player_in_team.basic=true
                k.update(basic:false)
              else
                @player_in_team.basic=false
              end
            else
              crs=Player.where(team_id:team.id,position1:player.position1).order("skill_level desc").limit(2).to_a
              if crs.size<2
                @player_in_team.basic=true
              elsif @player_in_team.skill_level>crs[0].skill_level || @player_in_team.skill_level>crs[1].skill_level
                @player_in_team.basic=true
                crs[1].update(basic:false)
              else
                @player_in_team.basic=false
              end
            end
            p=Player.where(team_id:team.id, none: false).order("price desc").first
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

  def update
    if @player_in_team.update(player_in_team_params)
      redirect_to @player_in_team, notice: 'Номер игрока изменён.'
    else
      render :edit
    end
  end

  def destroy
    # TODO вынести в отдельный сериалайзер
    if @player_in_team.basic
      pls = @team.players.where(position1: @player_in_team, state: 1, basic: false)
      pls.each do |pl|
        player.update!(basic: true) if pl.id != @player_in_team.id
      end
      @player_in_team.basic = false
      if @player_in_team.captain
        p = @team.players.order("price desc").limit(2)
        p.first.name == @player_in_team.name ? p.first.update!(captain: true) : p.last.update!(captain: true)
        @player_in_team.captain = false
      end
    end
    @player_in_team.update!(state: 0, team_id: nil)
    # TODO тут же добавить запись о забитых голах и т.д. и запись о клубе
    @team.update!(budget: @team.budget + @player_in_team.price / 2.0)
    redirect_to team, notice: 'Игрок уволен из Вашей команды и стал свободным агентом.'
  end

  private

  def set_player_in_team
    @player_in_team = Player.find(params[:id])
    @team = @player_in_team.team
  end

  def player_in_team_params
    params.require(:player_in_team).permit(:number, :team_id, :basic,:captain)
  end
end
