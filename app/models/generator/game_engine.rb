module Generator
  class GameEngine
    attr_reader :home_team, :home_team_game_params,
                :guest_team, :guest_team_game_params,
                :game, :game_params, :events

    def initialize(home, guest, game)
      @home_team = home
      @guest_team = guest
      @game = game
      @home_team_game_params = initialize_params_for_team(home)
      @guest_team_game_params = initialize_params_for_team(team)
      @game_params = GameSerializer.new(game)
      @events = []
    end

    def simulation
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
        penalty_serie if home_goals == guest_goals
      end
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

    def initialize_params_for_team(team)
      TeamInGameSerializer.new(team)
    end

    def calculate_event(minute)
      result = (@home_team.power_11.to_f / @guest_team.power_11).round(2)

      # Определение той команды, которая будет атаковать,
      # в зависимости от её силы и силы соперника
      if define_attacker(result) == 'home'
        attacker, defender = home_team, guest_team
        attacker_params = home_team_game_params
        defender_params = guest_team_game_params
      else
        attacker, defender = guest_team, home_team
        attacker_params = guest_team_game_params
        defender_params = home_team_game_params
      end
      minute_event_ary = Generator::EventEngine.new(
        minute,
        attacker, defender,
        attacker_params, defender_params,
        game_params
      ).start
      events << minute_event_ary unless event.blank?
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
end
