class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :admin_permission, except: [:show, :index]

  # GET /players
  # GET /players.json
  def index
    @players = Player.includes(:country).order("countries.title,players.name").search(params[:search]).page(params[:page])
    if @players.size.zero? && params[:search].blank?
      flash[:danger] = "Игроков с таким именем нет!"
      @projects = Player.where(inteam: false).includes(:country).order("countries.title,players.name").page(params[:page])
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    tal=player_params[:talent].to_i
    skill=player_params[:skill_level].to_i
    age=player_params[:age].to_i
    @player.price=(tal*10000.0*skill/age).round(3)
    @player.inteam=false
    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Игрок успешно создан.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    tal=player_params[:talent]
    skill=player_params[:skill_level]
    age=player_params[:age]
    @player.price=(tal.to_i*10000.0*skill.to_i/age.to_i).round(3)
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Игрок измёнен.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    raise "fuck u!"
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Игрок удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:name, :country_id, :position1, :position2, :talent, :age, :skill_level)#, :price)
    end
end
