class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
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
    @team.budget=1000000.0
    @team.fans=50
    respond_to do |format|
      if @team.save
        sp=Sponsor.find(@team.sponsor_id)
        sp.team_id=@team.sponsor_id
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
    sp=Sponsor.find(sp)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:title, :sponsor_id, :stadium_id, :club_basis_id, :budget, :fans)
    end
end
