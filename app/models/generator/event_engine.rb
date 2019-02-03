module Generator
  class EventEngine
    attr_reader :minute,
                :attacker, :defender,
                :attacker_params, :defender_params,
                :game_params,
                :attacker_squad,
                :attacker_main_squad, :attacker_reserve_squad,
                :defender_squad,
                :defender_main_squad, :defender_reserve_squad

    def initialize(minute, attacker, defender, attacker_prs, defender_prs, game_prs)
      @minute = minute
      @attacker = attacker
      @defender = defender
      @attacker_params = attacker_prs
      @defender_params = defender_prs
      @game_params = game_prs
      # @attacker_squad = home.players.to_a
      @attacker_main_squad = @attacker.players.where(basic: true).to_a
      @attacker_reserve_squad = @attacker.players.where(basic: false).to_a
      # @defender_squad = @defender.players.to_a
      @defender_main_squad = @defender.players.where(basic: true).to_a
      @defender_reserve_squad = @defender.players.where(basic: false).to_a
    end

    def start
      # все переменные для удобства генерации
      attacker_title   = attacker.title
      defender_title   = defender.title
      attacker_gk      = find_gk(attacker_main_squad)
      defender_gk      = find_gk(defender_main_squad)
      attacker_defs    = find_defenders(attacker_main_squad)
      defender_defs    = find_defenders(defender_main_squad)
      attacker_mids    = find_midfielders(attacker_main_squad)
      defender_mids    = find_midfielders(defender_main_squad)
      attacker_scorers = find_scorers(attacker_main_squad)
      defender_scorers = find_scorers(defender_main_squad)
      attacker_current_team_size = attacker_main_squad.size
      defender_current_team_size = defender_main_squad.size
      moments          = []

      # определение участвующих в эпизоде игроков
      player_attacker = attacker_main_squad.sample
      player_defender = defender_main_squad.sample

      # определение ценности момента
      j   = rand(5)
      act = rand(10000)

      case act
      when 0...4300
        return [] # Ничего не произошло
      when 4301...6400
        danger = 1 # Пас или другое развитие атаки
        moments << { kind: nil, player_id: player_attacker.id }
        # =["#{@team_attack[pl1].name} из команды #{@nam_attack} начинает атаку длинным забросом на чужую половину поля.", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается прорваться по флангу и делает сильную передачу вперед!", "#{@team_attack[pl1].name} из команды #{@nam_attack} выносит мяч далеко вперед!", "Игрок #{@team_attack[pl1].name} из команды #{@nam_attack} делает пас на партнера.", "#{@team_attack[pl1].name} из команды #{@nam_attack} демонстрирует прекрасный дриблинг в центре поля."]
      when 6401...7950
        danger = 2 # Пас или другое развитие атаки
        # var_moments=["#{@team_attack[pl1].name} из команды #{@nam_attack} обводит соперника в центре поля.", "#{@team_attack[pl1].name} из команды #{@nam_attack} несется с мячом через всё поле! Никто не может его остановить!", "#{@team_attack[pl1].name} из команды #{@nam_attack} делает длинный заброс вперед.", "Пас вразрез делает #{@team_attack[pl1].name} из команды #{@nam_attack}. Партнер успешно принимает мяч!", "#{@team_attack[pl1].name} из команды #{@nam_attack} со всей силы выносит мяч подальше от своих ворот!"]
      when 7951...9230
        danger = 3 # Аут, угловой, штрафной или перспективная атака
        # j=rand(7)
        # var_moments=["Аут вбрасывает #{@team_attack[pl1].name} из команды #{@nam_attack}.", "#{@team_attack[pl1].name} из команды #{@nam_attack} на всех парах несется к штрафной соперника! Может получится интересный момент!", "#{@team_attack[pl1].name} из команды #{@nam_attack} одного за другим обводит игроков соперника!", "#{@team_attack[pl1].name} из команды #{@nam_attack} продолжает атаку, начатую вратарем. Он принимает мяч неподалеку от штрафной соперника!", "#{@team_attack[pl1].name} из команды #{@nam_attack} начинает прорыв по флангу! Он демонстрирует отменную технику!", "Угловой зарабатывает команда #{@nam_attack}. #{@team_attack[pl1].name} отправился подавать.", "Штрафной пробьет #{@team_attack[pl1].name} из команды #{@nam_attack}."]
      else
        danger = 4 # Голевая возможность
        # j=rand(7)
        # var_moments=["Очень опасный момент! #{@team_attack[pl1].name} из команды #{@nam_attack} вкладывает всю силу в удар по воротам!", "#{@team_attack[pl1].name} из команды #{@nam_attack} прицельно бьёт по мячу!", "#{@team_attack[pl1].name} из команды #{@nam_attack} бьёт с лёту!", "#{@team_attack[pl1].name} из команды #{@nam_attack} останавливает мяч и опасно бьёт по воротам!", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается завершить атаку дальним ударом!", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается прорваться к воротам! Осталось всего двух защитников обыграть!", "#{@team_attack[pl1].name} из команды #{@nam_attack} делает пас вразрез, выводя своего партнера на рандеву с вратарем соперников!"]
      end



      # далее с.132 tmatch.rb
    end

    private

    def find_gk(squad)
      squad.select { |pl| pl if pl.gk? }
    end

    def find_defenders(squad)
      squad.select { |pl| pl if pl.position_defend?(pl.real_position) }
    end

    def find_midfielders(squad)
      squad.select { |pl| pl if pl.position_midfield?(pl.real_position) }
    end

    def find_scorers(squad)
      squad.select { |pl| pl if pl.position_attack?(pl.real_position) }
    end
  end
end
