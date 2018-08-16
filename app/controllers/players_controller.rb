class PlayersController < ApplicationController
  before_action :check_user
  before_action :set_player, except: %i[index new create]
  before_action :admin_permission, only: %i[new create]

  def index
    @players =
      if search_params
        Search.new(search_params).apply_search
      else
        Player.free_agent
      end
      .limit(200)
      .includes(:country)
      .order('countries.title, players.name')
      .page(params[:page])
  end

  def show; end

  def new
    @player = Player.new
  end

  def edit; end

  def create
    @player = Player.new(player_params)
    if Generator::RandomCharacteristics.new(@player).randomize.save!
      flash[:notice] = I18n.t('flash.players.created')
      redirect_to @player
    else
      render :new
    end
  end

  def buy_processing; end

  def buy
    # TODO подумать, как это отрефакторить
    # приходит id игрока
    cb = @current_user_team.club_base if @current_user_team
    # если игрок нашелся по id и свободен
    if !@current_user_team
      flash[:danger] = I18n.t('flash.players.no_team')
      redirect_to @current_user
    elsif @player.state != 'free_agent'
      flash[:danger] = I18n.t('flash.players.not_available')
      redirect_to players_path
    elsif !cb
      flash[:danger] = I18n.t('flash.players.no_club_base')
      redirect_to @current_user_team
    elsif cb.capacity == @current_user_team.squad_size
      flash[:danger] = I18n.t('flash.players.club_base_low_level')
      redirect_to [@current_user_team, cb]
    elsif @current_user_team.low_budget?(@player.price)
      flash[:danger] = I18n.t('flash.players.not_enough_money')
      redirect_to players_path
    else # приобретение игрока возможно
      # TODO: вынести в новый модуль Bying
      ActiveRecord::Base.transaction do
        @player.state = 1
        @player.team_id = @current_user_team.id
        @player.number = buy_processing_params[:number]
        if buy_processing_params[:basic] == 'true'
          @current_user_team.players.where(
            position1: @player.position1, basic: true
          ).first.update(basic: false)
          @player.basic = buy_processing_params[:basic]
        end
        captain = @current_user_team.captain
        if @player.skill_level > captain.skill_level
          @player.captain = true
          captain.update(captain: false)
        end
        if @player.save
          @current_user_team.budget -= @player.price
          @current_user_team.save!
          Career.create(
            player_id: @player.id,
            age_begin: @player.age,
            team_title: @current_user_team.title
          )
          @current_user_team.operations.create(
            sum: @player.price,
            kind: false,
            title: I18n.t('messages.operation.player_bying')
          )
          flash[:notice] = I18n.t('flash.players.buyed')
          redirect_to @player
        else
          render :buy_processing
        end
      end
    end
  end

  def sell
    if @player.team != @current_user_team
      flash[:danger] = I18n.t('flash.insufficient_privileges')
      redirect_to @player
    elsif @current_user_team.low_squad?
      flash[:danger] = I18n.t('flash.teams.low_squad')
      redirect_to @current_user_team
    elsif @player.injured || !@player.can_play || games_missed > 0
      flash[:danger] = I18n.t('flash.players.was_disqualified')
      redirect_to @player
    else
      ActiveRecord::Base.transaction do
        if @player.basic
          # TODO если игрока в запасе на такую позицию нету, ставь игрока ближайшей позиции с потерей навыка
          pl = @current_user_team.players.where(position1: @player.position1, basic: false).order('skill_level desc').first
          if pl
            pl.update(basic: true)
            @player.basic = false
            if @player.captain
              p = @current_user_team.players.order('skill_level desc').limit(1).offset(1)
              p.update(captain: true)
              @player.captain = false
            end
          else
            flash[:danger] = I18n.t('flash.players.last')
            redirect_to @player
          end
        end
        @player.update(state: 0, team_id: nil, number: nil)
        if career = @player.careers.active.first
          career.update_attributes(active: false, age_end: @player.age)
        else
          @player.careers.create(
            active: false, age_begin: @player.age, age_end: @player.age,
            team_title: @current_user_team.title
          ).save!
        end
        @current_user_team.budget += @player.price / 2.0
        @current_user_team.save
        @current_user_team.operations.create(
          sum: @player.price / 2.0,
          kind: true,
          title: I18n.t('messages.operation.player_sale_to_free_agents')
        )
      end
      flash[:notice] = I18n.t('flash.players.sold')
      redirect_to @current_user_team
    end
  end

  def training; end

  def update
    # TODO продумать update, хотя бы минимальный
    skill = player_params[:skill_level]
    tal = player_params[:talent]
    age = player_params[:age]
    @player.price = Player.calc_price(skill, tal, age)
    if @player.update(player_params)
      flash[:notice] = I18n.t('flash.players.edited')
      redirect_to @player
    else
      render :edit
    end
  end

  # upgrade ALL characteristics
  Player::CHARACTERISTICS.each do |charc|
    define_method "#{charc}_upgrade" do
      new_level = @player.skill_level + 1
      pts = @player.training_points - Definer.need_points(@player.send(charc))
      upgrade_params = {
        charc => @player.send(charc) + 1,
        training_points: pts,
        skill_level: new_level,
        price: Player.calc_price(new_level, @player.talent, @player.age)
      }
      @player.update(upgrade_params)
      flash[:notice] = I18n.t(
        'flash.players.characteristics_improved', name: @player.name
      )
      if params[:location] != 'show'
        redirect_to training_team_path(@current_user_team)
      else
        redirect_to @player
      end
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(
      :name, :country_id, :position1, :position2, :talent, :age, :skill_level
    )
  end

  def buy_processing_params
    params.require(:player).permit(:number, :basic)
  end

  def search_params
    return if params[:search].blank?
    params.require(:search).permit(
      :name, :country_id, :position1, :skill_level, :talent, :age
    )
  end
end
