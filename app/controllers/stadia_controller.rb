class StadiaController < ApplicationController
  before_action :set_stadium, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: :new
  before_action :admin_permission, only: :destroy

  # GET /stadia
  # GET /stadia.json
  def index
    @stadia = Stadium.all
  end

  # GET /stadia/1
  # GET /stadia/1.json
  def show
    @team=Team.find(@stadium.team_id)
    @user=User.find(@team.user_id)
  end

  # GET /stadia/new
  def new
    @stadium = Stadium.new
    @stadium.team_id=@team.id
  end

  # GET /stadia/1/edit
  def edit
  end

  # POST /stadia
  # POST /stadia.json
  def create
    hash=params
    other_hash={"stadium"=>params[:stadium]}
    stadium_params.delete(hash.keys[0])
    stadium_params.update(other_hash)
    @stadium = Stadium.new(stadium_params)
    @team=Team.find(stadium_params[:team_id])
    @stadium.team=@team
    @stadium.capacity=200
    @stadium.level=1
    respond_to do |format|
      if @stadium.save
        @team.stadium_id=@stadium.id
        @team.save!
        format.html { redirect_to @stadium, notice: 'Стадион успешно создан.' }
        format.json { render :show, status: :created, location: @stadium }
      else
        format.html { render :new }
        format.json { render json: @stadium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stadia/1
  # PATCH/PUT /stadia/1.json
  def update
    respond_to do |format|
      if @stadium.update(stadium_params)
        format.html { redirect_to @stadium, notice: 'Стадион успешно изменён.' }
        format.json { render :show, status: :ok, location: @stadium }
      else
        format.html { render :edit }
        format.json { render json: @stadium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stadia/1
  # DELETE /stadia/1.json
  def destroy
    @stadium.destroy
    respond_to do |format|
      format.html { redirect_to stadia_url, notice: 'Стадион удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stadium
      @stadium = Stadium.find(params[:id])
    end

    def set_team
      @team = Team.find(params[:team_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def stadium_params
      params.require(:stadium).permit(:title,:team_id)#, :capacity, :level, :team_id)
    end
end
