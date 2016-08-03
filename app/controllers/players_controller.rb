class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:buy_player]
  before_action :admin_permission, except: [:show, :index]

  def index
    @players = Player.includes(:country).order('countries.title, players.name').search(params[:search]).page(params[:page])
    if @players.blank? && params[:search].blank?
      flash[:danger] = 'Игроков с таким именем нет!'
      @players = Player.where(in_team: false, state: 0).includes(:country).order('countries.title, players.name').page(params[:page])
    end
  end

  def show
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)
    tal = player_params[:talent].to_i
    skill = player_params[:skill_level].to_i
    age = player_params[:age].to_i
    @player.price = (tal * 10000.0 * skill / age).round(3)
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

  def buy_player
    # приходит id игрока
    cb = ClubBase.find(@current_user_team.club_basis_id) if @current_user_team
    # если игрок нашелся по id и свободен
    @player = Player.find(params[:id])
    unless @current_user_team
      flash[:danger] = 'Прежде, чем покупать игроков, создайте команду!'
      redirect_to new_team_path
    elsif @player.state != 0 || @player.in_team
      flash[:danger] = 'Произошла ошибка!'
      redirect_to players_path
    elsif cb.capacity == @current_user_team.players.count
      flash[:danger] = 'Расширьте базу клуба для покупки новых игроков!'
      redirect_to cb
    elsif @current_user_team.budget < @player.price
      flash[:danger] = 'На счету Вашей команды недостаточно средств для покупки данного игрока!'
      redirect_to players_path
    else # приобретение игрока возможно
      @player.in_team = true
      @player.state = 1
      @player.team = @current_user_team
      captain = @current_user_team.players.order('price desc').limit(1)
      if @player.price > captain.price
        @player.captain = true
        captain.update!(captain: false)
      end

      respond_to do |format|
        if @player.save
          @current_user_team.players << @player
          @current_user_team.budget -= @player.price
          @current_user_team.save!

          format.html { redirect_to @player, notice: 'Игрок куплен.' }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    # TODO продумать update, хотя бы минимальный
    tal = player_params[:talent]
    skill = player_params[:skill_level]
    age = player_params[:age]
    @player.price = (tal.to_i * 10000.0 * skill.to_i / age.to_i).round(3)
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

  # def destroy
  #   # TODO продумать удаление
  #   raise "fuck u!"
  #   @player.destroy
  #   respond_to do |format|
  #     format.html { redirect_to players_url, notice: 'Игрок удалён.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(
        :name, :country_id, :position1, :position2,
        :talent, :age, :skill_level
      ) #, :price)
    end
end
