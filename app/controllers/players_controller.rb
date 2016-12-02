class PlayersController < ApplicationController
  before_action :set_player, except: [:index, :new, :create]
  before_action :admin_permission, only: [:new, :create, :destroy]

  def index
    if search_params
      @players = Search.new(search_params).apply_search.limit(200).includes(:country).order('countries.title, players.name').page(params[:page])
    else
      @players = Player.where(state: 0).limit(500).includes(:country).order('countries.title, players.name').page(params[:page])
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
    if @player.save
      redirect_to @player, notice: 'Игрок успешно создан.'
    else
      render :new
    end
  end

  def buy
    # приходит id игрока
    cb = @current_user_team.club_base
    # если игрок нашелся по id и свободен
    if !@current_user_team
      flash[:danger] = 'Прежде, чем покупать игроков, создайте команду!'
      redirect_to @current_user
    elsif @player.state != 'free_agent'
      flash[:danger] = 'Игрок недоступен для покупки!'
      redirect_to players_path
    elsif !cb
      flash[:danger] = 'Создайте базу клуба, чтобы покупать новых игроков!'
      redirect_to @current_user_team
    elsif cb.capacity == @current_user_team.players.count
      flash[:danger] = 'Расширьте базу клуба для покупки новых игроков!'
      redirect_to cb
    elsif @current_user_team.budget < @player.price
      flash[:danger] = 'На счету Вашей команды недостаточно средств для покупки данного игрока!'
      redirect_to players_path
    else # приобретение игрока возможно
      ActiveRecord::Base.transaction do
        @player.state = 1
        @player.team_id = @current_user_team.id
        @player.number = PlayerGenerator.rand_number(@current_user_team.players.map(&:number))
        captain = @current_user_team.captain
        if @player.price > captain.price
          @player.captain = true
          captain.update!(captain: false)
        end
        if @player.save
          @current_user_team.budget -= @player.price
          @current_user_team.save!
          redirect_to @player, notice: 'Игрок куплен.'
        else
          render :index
        end
      end
    end
  end

  def sell
    ActiveRecord::Base.transaction do
      # TODO сделать по человечески
      # if @player.basic
      #   pls = @current_user_team.players.where(position1: @player.position1, state: 1, basic: false)
      #   pls.each do |pl|
      #     @player.update!(basic: true) if pl.id != @player.id
      #   end
      #   @player.basic = false
      #   if @player.captain
      #     p = @current_user_team.players.order("price desc").limit(2)
      #     p.first.name == @player.name ? p.first.update!(captain: true) : p.last.update!(captain: true)
      #     @player.captain = false
      #   end
      # end
      @player.update!(state: 0, team_id: nil)
      # TODO тут же добавить запись о забитых голах и т.д. и запись о клубе
      @current_user_team.update!(budget: @current_user_team.budget + @player.price / 2.0)
    end
    redirect_to @current_user_team, notice: 'Игрок уволен из Вашей команды и стал свободным агентом.'
  end

  def update
    # TODO продумать update, хотя бы минимальный
    tal = player_params[:talent]
    skill = player_params[:skill_level]
    age = player_params[:age]
    @player.price = (tal.to_i * 10000.0 * skill.to_i / age.to_f).round(3)
    if @player.update(player_params)
      redirect_to @player, notice: 'Игрок измёнен.'
    else
      render :edit
    end
  end

  def destroy
  #   # TODO продумать удаление
  #   raise "fuck u!"
  #   @player.destroy
  #   redirect_to players_url, notice: 'Игрок удалён.'
  end

  private
    
  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(
      :name, :country_id, :position1, :position2,
      :talent, :age, :skill_level
    )
  end

  def search_params
    return if params[:search].blank?
    params.require(:search).permit(
      :name, :country_id, :position1, :skill_level, :talent, :age
    )
  end
end
