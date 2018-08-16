class Game < ActiveRecord::Base
  belongs_to :home, class_name: 'Team', inverse_of: :games
  belongs_to :guest, class_name: 'Team', inverse_of: :games

  has_one :game_statistic

  has_many :game_events, dependent: :destroy
  has_many :game_players, dependent: :destroy

  def league? # игра лиги
    kind
  end

  def tournament
    klass = league? ? League : Cup
    klass.find(tournament_id)
  end

  def who_plays
    "#{home.title} - #{guest.title}"
  end

  def simulation
    set_teams
    ActiveRecord::Base.transaction do
      # first period
      first_main_period
      # second period
      second_main_period
      # если победителя нет, и матч кубковый
      # добавить сюда учет первого матча, если серия из 2х матчей
      if home_goals == guest_goals && !league?
        first_additional_period
        second_additional_period
        # если опять ничья, то серия пенальти
        if home_goals == guest_goals
          penalty_serie
        end
      end
    end
    self
  end

  def set_teams
    @home_team = self.home
    @home_team_squad = @home_team.players
    @home_team_main_squad = @home_team.players.where(basic: true)
    @home_team_reserve_squad = @home_team.players.where(basic: false)
    @guest_team = self.guest
    @guest_team_squad = @guest_team.players
    @guest_team_main_squad = @guest_team.players.where(basic: true)
    @guest_team_reserve_squad = @guest_team.players.where(basic: false)
  end

  private

  def first_main_period
    (1..45).each do |minute|
      calculate_event(minute)
    end
  end

  def second_main_period
    (46..90).each do |minute|
      calculate_event(minute)
    end
  end

  def first_additional_period
    (91..105).each do |minute|
      calculate_event(minute)
    end
  end

  def second_additional_period
    (106..120).each do |minute|
      calculate_event(minute)
    end
  end

  def additional_time(time = rand(100))
    random = time
    case random
    when 0...23
      0
    when 23...62
      1
    when 62...85
      2
    when 85...94
      3
    else
      rand(2) + 4
    end
  end

  def penalty_serie
  end

  def calculate_event(minute)
    result = @home_team.power_11.to_f / @guest_team.power_11.to_f

    # Определение той команды, которая будет атаковать,
    # в зависимости от её силы и силы соперника
    if define_attacker(result) == 'home'
      attacker, defender = @home_team, @guest_team
    else
      attacker, defender = @guest_team, @home_team
    end

    # все переменные для удобства генерации
    attacker_title = attacker.title
    defender_title = defender.title
    attacker_keeper = attacker.main_gk
    defender_keeper = defender.main_gk
    attacker_defs = attacker.main_ld_cd_rd
    defender_defs = defender.main_ld_cd_rd
    attacker_mids = attacker.main_lm_cm_rm
    defender_mids = defender.main_lm_cm_rm
    attacker_attacks = attacker.main_lf_cf_rf
    defender_attacks = defender.main_lf_cf_rf

    # далее с.132 tmatch.rb
    
  end

  def define_attacker(difference)
    var = rand(10) + 1

    case difference
    when 0.0...0.25
      var == 1 ? 'home' : 'guest'
    when 0.25...0.5
      var <= 2 ? 'home' : 'guest'
    when 0.5...0.75
      var <= 3 ? 'home' : 'guest'
    when 0.75...0.9
      var <= 4 ? 'home' : 'guest'
    when 0.9...1.1
      var <= 5 ? 'home' : 'guest'
    when 1.1...1.25
      var <= 6 ? 'home' : 'guest'
    when 1.25...2.0
      var <= 7 ? 'home' : 'guest'
    when 2.0...4.0
      var <= 8 ? 'home' : 'guest'
    else
      var <= 9 ? 'home' : 'guest'
    end
  end
end
