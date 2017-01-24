class PlayersController < ApplicationController
  before_action :check_user
  before_action :set_player, except: [:index, :new, :create]
  before_action :admin_permission, only: [:new, :create]

  def index
    if search_params
      @players = Search.new(search_params).apply_search.limit(200).includes(:country).order('countries.title, players.name').page(params[:page])
    else
      @players = Player.free_agent.limit(200).includes(:country).order('countries.title, players.name').page(params[:page])
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
    if Generator::RandomCharacteristics.new(@player).randomize.save!
      flash[:notice] = I18n.t('flash.players.created')
      redirect_to @player
    else
      render :new
    end
  end

  def buy_processing
  end

  def buy
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
      redirect_to cb
    elsif @current_user_team.budget < @player.price
      flash[:danger] = I18n.t('flash.players.not_enough_money')
      redirect_to players_path
    else # приобретение игрока возможно
      ActiveRecord::Base.transaction do
        @player.state = 1
        @player.team_id = @current_user_team.id
        @player.number = buy_processing_params[:number]
        if buy_processing_params[:basic] == 'true'
          @current_user_team.players.where(position1: @player.position1, basic: true).first.update(basic: false)
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
          Career.create(player_id: @player.id, age_begin: @player.age, team_title: @current_user_team.title)
          Operation.create(team_id: @current_user_team.id, sum: @player.price, kind: false, title: 'Покупка игрока')
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
    elsif @current_user_team.squad_size < 15
      flash[:danger] = I18n.t('flash.teams.low_squad')
      redirect_to @current_user_team
    else
      # TODO добавить проверку на то, есть ли травмы или дисквалификации - нельзя продавать тогда.
      ActiveRecord::Base.transaction do
        if @player.basic
          #TODO если игркоа в запасе на такую позицию нету, ставь игрока ближайшей позиции с потерей навыка
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
        @player.careers.active.first.update(active: false, age_end: @player.age)
        @current_user_team.budget += @player.price / 2.0
        @current_user_team.save
        Operation.create(team_id: @current_user_team.id, sum: @player.price / 2.0, kind: true, title: 'Продажа игрока на рынок свободных агентов')
      end
      flash[:notice] = I18n.t('flash.players.sold')
      redirect_to @current_user_team
    end
  end

  def training
  end

  def update
    # TODO продумать update, хотя бы минимальный
    tal = player_params[:talent]
    skill = player_params[:skill_level]
    age = player_params[:age]
    @player.price = (tal.to_i * 10000.0 * skill.to_i / age.to_f).round(3)
    if @player.update(player_params)
      flash[:notice] = I18n.t('flash.players.edited')
      redirect_to @player
    else
      render :edit
    end
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

  def buy_processing_params
    params.require(:player).permit(
      :number, :basic
    )
  end

  def search_params
    return if params[:search].blank?
    params.require(:search).permit(
      :name, :country_id, :position1, :skill_level, :talent, :age
    )
  end
end
