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
      redirect_to [@current_user_team, cb]
    elsif @current_user_team.budget < @player.price
      flash[:danger] = I18n.t('flash.players.not_enough_money')
      redirect_to players_path
    else # приобретение игрока возможно
      # TODO: вынести в новый модуль Bying
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
    # TODO убрать skill
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
  
  # upgrade characteristics
  # TODO переписать на JS!!!
  # либо рефакторнуть
  def tackling_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.tackling + 1
    new_training_points = @player.training_points - Definer.need_points(@player.tackling)
    @player.update(tackling: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    if params[:location] != 'show'
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def marking_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.marking + 1
    new_training_points = @player.training_points - Definer.need_points(@player.marking)
    @player.update(marking: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def positioning_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.positioning + 1
    new_training_points = @player.training_points - Definer.need_points(@player.positioning)
    @player.update(positioning: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def heading_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.heading + 1
    new_training_points = @player.training_points - Definer.need_points(@player.heading)
    @player.update(heading: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def pressure_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.pressure + 1
    new_training_points = @player.training_points - Definer.need_points(@player.pressure)
    @player.update(pressure: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def shot_accuracy_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.shot_accuracy + 1
    new_training_points = @player.training_points - Definer.need_points(@player.shot_accuracy)
    @player.update(shot_accuracy: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def shot_power_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.shot_power + 1
    new_training_points = @player.training_points - Definer.need_points(@player.shot_power)
    @player.update(shot_power: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def dribbling_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.dribbling + 1
    new_training_points = @player.training_points - Definer.need_points(@player.dribbling)
    @player.update(dribbling: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def passing_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.passing + 1
    new_training_points = @player.training_points - Definer.need_points(@player.passing)
    @player.update(passing: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def carport_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.carport + 1
    new_training_points = @player.training_points - Definer.need_points(@player.carport)
    @player.update(carport: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def speed_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.speed + 1
    new_training_points = @player.training_points - Definer.need_points(@player.speed)
    @player.update(speed: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def endurance_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.endurance + 1
    new_training_points = @player.training_points - Definer.need_points(@player.endurance)
    @player.update(endurance: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def reaction_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.reaction + 1
    new_training_points = @player.training_points - Definer.need_points(@player.reaction)
    @player.update(reaction: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def aggression_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.aggression + 1
    new_training_points = @player.training_points - Definer.need_points(@player.aggression)
    @player.update(aggression: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
    end
  end

  def creativity_upgrade
    new_skill_level = @player.skill_level + 1
    new_price = Player.calc_price(new_skill_level, @player.talent, @player.age)
    new_val = @player.creativity + 1
    new_training_points = @player.training_points - Definer.need_points(@player.creativity)
    @player.update(creativity: new_val, training_points: new_training_points, price: new_price, skill_level: new_skill_level)
    flash[:notice] = I18n.t('flash.players.characteristics_improved', name: @player.name)
    unless params[:location]
      redirect_to training_team_path(@current_user_team)
    else
      redirect_to @player
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
