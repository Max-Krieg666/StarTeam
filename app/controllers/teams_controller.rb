class TeamsController < ApplicationController
  before_action :check_user, except: [:get_players]
  before_action :set_team, except: [:destroy, :index, :get_players]
  before_action :check_owner, except: [:destroy, :index, :show, :get_players]
  before_action :set_variables, only: [:show, :statistics]

  def index
    @teams = Team.order('title')
  end

  def show; end

  def line_up; end

  def statistics; end

  def get_players
    # TODO add Serializer for this case
    render json: { players: Player.where(team_id: params[:id]) }
  end

  def training
    @players = @team.basic_order
  end

  def operations
    @financies = @team.operations.order('created_at desc').page(params[:page])
  end

  def transfer_history
    @in = Transfer.where(status: 1, purchaser_id: @current_user_team.id)
    @out = Transfer.where(status: 1, vendor_id: @current_user_team.id)
  end

  def edit; end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: I18n.t('flash.teams.title_changed') }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    # TODO при удалении команды отпускать на свободный рынок всех игроков в ней
    # а всё остальное уничтожать!
    respond_to do |format|
      format.html { redirect_to @current_user, notice: I18n.t('flash.teams.destroyed') }
      format.json { head :no_content }
    end
  end

  private
  
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    attrs = [:title]
    attrs += [:budget, :fans, :sponsor] if @current_user.try(:admin?)
    params.require(:team).permit(*attrs)
  end

  def set_variables
    @players = @team.basic_order
    @club_base = @team.club_base
    @stadium = @team.stadium
  end

  def check_owner
    return if @team == @current_user_team

    flash[:danger] = I18n.t('flash.access_denied')
    redirect_to @current_user_team
  end
end
