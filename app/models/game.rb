class Game < ActiveRecord::Base
  belongs_to :home, class_name: 'Team'
  belongs_to :guest, class_name: 'Team'

  def league? # игра лиги
    kind
  end

  def tournament
    klass = league? ? League : Cup
    klass.find(tournament_id)
  end

  def simulation
    set_teams
    # first period
    first_main_period
    # second period
    second_main_period
    # если победителя нет, и матч кубковый
    # добавить сюда учет первого матча,если серия из 2х матчей
    if home_goals == guest_goals && !league?
      first_additional_period
      second_additional_period
      # если опять ничья, то серия пенальти
      if home_goals == guest_goals
        penalty_serie
      end
    end
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
      calculate_event
    end
  end

  def second_main_period
    (46..90).each do |minute|
      calculate_event
    end
  end

  def first_additional_period
    (91..105).each do |minute|
      calculate_event
    end
  end

  def second_additional_period
    (106..120).each do |minute|
      calculate_event
    end
  end

  def additional_time(time = rand(100))
    random = time
    if random > 95
      rand(2) + 4
    elsif random > 85
      3
    elsif random > 62 && random <= 85
      2
    elsif random > 39 && random <= 62
      1
    else
      0
    end
  end

  def penalty_serie
  end

  def calculate_event
    set_teams
  end
end
