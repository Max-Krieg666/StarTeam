class TeamsController < ApplicationController
  before_action :check_user
  before_action :set_team, except: [:destroy, :index]

  def index
    @teams = Team.order('title')
  end

  def show
    @players = @team.players.order('basic desc, position1 asc, skill_level desc')
    @club_base = @team.club_base
    @stadium = @team.stadium
  end

  def edit
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

  def team_params
    attrs = [:title]
    if @current_user.try(:admin?)
      attrs += [:budget, :fans, :sponsor]
    end
    params.require(:team).permit(*attrs)
  end
end
