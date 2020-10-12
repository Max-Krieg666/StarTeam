module Generator
  # класс для рандомизации команды
  class RandomTeam
    attr_reader :team, :main_country_id, :numbers, :count_main, :count_foreigners

    def initialize(team)
      @team = team
      @main_country_id = team.country_id
      @numbers = []
      @count_main = 0 # 13 игроков из основной страны
      @count_foreigners = 0 # 5 игроков-иностранцев
    end

    def generate
      random_formation = Formation.order('random()').first
      @team.formation = random_formation
      @team.save
      footballers_per_position = random_formation.with_reserve_players_before_generation
      footballers_per_position.each do |pos, count|
        pos_players = []
        count.times do
          # рандомный выбор по странам игроков в порядке позиций
          pos_players << random_player(random_country_id, pos)
        end
        begin
          # игроки основного состава
          number_of_players = @team.formation.number_of_players_for_position(pos)
          pos_players.sort_by(&:skill_level).last(number_of_players).each do |pl|
            pl.basic = true
            pl.careers.build(age_begin: pl.age, team_title: @team.title)
            pl.save
          end
          # игроки резерва
          pos_players.sort_by(&:skill_level).first(count - number_of_players).each do |pl|
            pl.careers.build(age_begin: pl.age, team_title: @team.title)
            pl.save
          end
        rescue ActiveRecord::RecordInvalid
          pl.name = RandomName.new(pl.country_id).rand_name
          pl.save
        end
      end
      @team
    end

    private

    def random_player(country_id, pos = nil)
      pl = Player.new
      pl.team_id = @team.id
      pl.country_id = country_id
      pl.name = RandomName.new(country_id).rand_name
      pl.position1 = pos || SecureRandom.random_number(RandomPlayer::POS.size)
      pl.state = 1
      pl.basic = false
      pl.talent = RandomPlayer.rand_talent
      pl.age = RandomPlayer.rand_age(pl.talent)
      pl.skill_level = RandomPlayer.rand_skill_level(pl.talent)
      pl.number = RandomPlayer.rand_number(@numbers)
      @numbers << pl.number
      pl = RandomCharacteristics.new(pl).randomize
      pl
    end

    def random_country_id
      chance = SecureRandom.random_number(100)
      if chance > 76 && @count_foreigners < 5 || @count_main == 13
        k = SecureRandom.random_number(252) + 1
        k = SecureRandom.random_number(252) + 1 while k == @main_country_id
        @count_foreigners += 1
        k
      elsif chance <= 76 && @count_main < 13 || @count_foreigners == 5
        @count_main += 1
        @main_country_id
      end
    end
  end
end
