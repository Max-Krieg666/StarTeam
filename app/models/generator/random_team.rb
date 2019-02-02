module Generator
  # класс для рандомизации команды
  class RandomTeam
    attr_reader :team, :main_country_id, :numbers

    SCHEMAS = [
      '4-4-2>1', '4-4-2>2', '4-4-2>3', '4-4-2>4',
      '4-3-3>1', '4-3-3>2', '4-3-3>3',
      '3-5-2>1', '3-5-2>2', '3-5-2>3',
      '3-4-3>1', '3-4-3>2', '3-4-3>3', '3-4-3>4', '3-4-3>5', '3-4-3>6',
      '4-2-4>1', '4-2-4>2', '4-2-4>3'
    ].freeze

    FOOTBALLERS_POSITIONS = {
      SCHEMAS[0] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [2, 1], 4 => [1, 1], 5 => [3, 2], 6 => [2, 1], 7 => [1, 1], 8 => [2, 1], 9 => [1, 0] },
      SCHEMAS[1] => { 0 => [2, 1], 1 => [2, 1], 2 => [3, 2], 3 => [1, 1], 4 => [2, 1], 5 => [3, 2], 6 => [1, 1], 7 => [1, 0], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[2] => { 0 => [2, 1], 1 => [2, 1], 2 => [3, 2], 3 => [1, 1], 4 => [2, 1], 5 => [3, 2], 6 => [2, 1], 8 => [3, 2] },
      SCHEMAS[3] => { 0 => [2, 1], 1 => [2, 1], 2 => [3, 2], 3 => [2, 1], 4 => [2, 1], 5 => [3, 2], 6 => [1, 1], 8 => [3, 2] },
      SCHEMAS[4] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [2, 1], 4 => [2, 1], 5 => [3, 2], 6 => [1, 1], 7 => [1, 0], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[5] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 1], 3 => [1, 1], 4 => [1, 1], 5 => [3, 2], 6 => [1, 1], 7 => [2, 1], 8 => [2, 1], 9 => [2, 1] },
      SCHEMAS[6] => { 0 => [2, 1], 1 => [2, 1], 2 => [2, 1], 3 => [2, 1], 4 => [1, 1], 5 => [3, 2], 6 => [2, 1], 7 => [1, 1], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[7] => { 0 => [2, 1], 1 => [1, 1], 2 => [2, 1], 3 => [1, 1], 4 => [2, 1], 5 => [4, 3], 6 => [2, 1], 7 => [1, 0], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[8] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [1, 1], 4 => [2, 1], 5 => [4, 2], 6 => [1, 1], 7 => [1, 1], 8 => [2, 1], 9 => [1, 0] },
      SCHEMAS[9] => { 0 => [2, 1], 1 => [2, 1], 2 => [2, 1], 3 => [1, 1], 4 => [2, 1], 5 => [4, 3], 6 => [2, 1], 7 => [1, 0], 8 => [1, 1], 9 => [1, 1] },
      SCHEMAS[10] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [1, 1], 4 => [2, 1], 5 => [3, 2], 6 => [2, 1], 7 => [1, 0], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[11] => { 0 => [2, 1], 1 => [1, 1], 2 => [2, 1], 3 => [2, 1], 4 => [1, 1], 5 => [3, 2], 6 => [2, 1], 7 => [2, 1], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[12] => { 0 => [2, 1], 1 => [1, 1], 2 => [2, 1], 3 => [2, 1], 4 => [2, 1], 5 => [3, 2], 6 => [1, 1], 7 => [1, 1], 8 => [2, 1], 9 => [2, 1] },
      SCHEMAS[13] => { 0 => [2, 1], 1 => [2, 1], 2 => [2, 1], 3 => [1, 1], 4 => [2, 1], 5 => [3, 2], 6 => [1, 1], 7 => [2, 1], 8 => [2, 1], 9 => [1, 1] },
      SCHEMAS[14] => { 0 => [2, 1], 1 => [2, 1], 2 => [2, 1], 3 => [1, 1], 4 => [2, 1], 5 => [3, 2], 6 => [2, 1], 8 => [4, 3] },
      SCHEMAS[15] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [1, 1], 4 => [2, 1], 5 => [4, 2], 6 => [1, 1], 8 => [4, 2] },
      SCHEMAS[16] => { 0 => [2, 1], 1 => [2, 1], 2 => [3, 2], 3 => [1, 1], 4 => [1, 1], 5 => [3, 2], 6 => [1, 1], 7 => [2, 1], 8 => [2, 1], 9 => [1, 0] },
      SCHEMAS[17] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [2, 1], 4 => [1, 1], 5 => [3, 2], 6 => [1, 1], 7 => [1, 0], 8 => [3, 2], 9 => [1, 0] },
      SCHEMAS[18] => { 0 => [2, 1], 1 => [1, 1], 2 => [3, 2], 3 => [1, 1], 4 => [1, 1], 5 => [2, 1], 6 => [2, 1], 7 => [2, 1], 8 => [2, 1], 9 => [2, 1] }
    }.freeze

    def initialize(team)
      @team = team
      @main_country_id = team.country_id
      @numbers = []
    end

    def generate
      schema = SCHEMAS[SecureRandom.random_number(19)]
      count_main = 0 # д.б. 13
      count_foreigners = 0 # д.б. 5
      footballers_positions = FOOTBALLERS_POSITIONS[schema]
      footballers_positions.each do |pos, count|
        pos_players = []
        count.first.times do
          # рандомный выбор по странам игроков в порядке - по позициям
          chance = SecureRandom.random_number(100)
          if chance > 76 && count_foreigners < 5 || count_main == 13
            k = SecureRandom.random_number(252) + 1
            k = SecureRandom.random_number(252) + 1 while k == @main_country_id
            pl_c_id = k
            count_foreigners += 1
          elsif chance <= 76 && count_main < 13 || count_foreigners == 5
            pl_c_id = @main_country_id
            count_main += 1
          end
          pos_players << random_player(pl_c_id, pos)
        end
        pos_players.sort_by(&:skill_level).last(count.last).each do |p|
          p.update(basic: true)
        end
      end
    end

    private

    def random_player(country_id, pos = nil)
      pl = Player.new
      pl.team_id = @team.id
      pl.country_id = country_id
      pl.name = Generator::RandomName.new(country_id).rand_name
      pl.position1 =
        pos || SecureRandom.random_number(Generator::RandomPlayer::POS.size)
      pl.state = 1
      pl.basic = false
      pl.talent = Generator::RandomPlayer.rand_talent
      pl.age = Generator::RandomPlayer.rand_age(pl.talent)
      pl.skill_level = Generator::RandomPlayer.rand_skill_level(pl.talent)
      pl.number = Generator::RandomPlayer.rand_number(@numbers)
      Generator::RandomCharacteristics.new(pl).randomize.save!
      pl.careers.create(age_begin: pl.age, team_title: @team.title)
      @numbers << pl.number
      pl
    rescue ActiveRecord::RecordInvalid
      pl.name = Generator::RandomName.new(country_id).rand_name
      pl.save!
      pl
    end
  end
end
