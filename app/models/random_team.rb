class RandomTeam
  attr_reader :team, :main_country_id, :numbers
  # класс для рандомизации команды

  SCHEMAS = [
    '4-4-2>1', '4-4-2>2', '4-4-2>3', '4-4-2>4',
    '4-3-3>1', '4-3-3>2', '4-3-3>3',
    '3-5-2>1', '3-5-2>2', '3-5-2>3',
    '3-4-3>1', '3-4-3>2', '3-4-3>3', '3-4-3>4', '3-4-3>5', '3-4-3>6',
    '4-2-4>1', '4-2-4>2', '4-2-4>3'
  ]

  FOOTBALLERS_POSITIONS = {
  	SCHEMAS[0] => { 0 => 2, 1 => 1, 2 => 3, 3 => 2, 4 => 1, 5 => 3, 6 => 2, 7 => 1, 8 => 2, 9 => 1 },
  	SCHEMAS[1] => { 0 => 2, 1 => 2, 2 => 3, 3 => 1, 4 => 2, 5 => 3, 6 => 1, 7 => 1, 8 => 2, 9 => 1 },
  	SCHEMAS[2] => { 0 => 2, 1 => 2, 2 => 3, 3 => 1, 4 => 2, 5 => 3, 6 => 2, 8 => 3 },
  	SCHEMAS[3] => { 0 => 2, 1 => 2, 2 => 3, 3 => 2, 4 => 2, 5 => 3, 6 => 1, 8 => 3 },
    SCHEMAS[4] => { 0 => 2, 1 => 1, 2 => 3, 3 => 2, 4 => 2, 5 => 3, 6 => 1, 7 => 1, 8 => 2, 9 => 1 },
    SCHEMAS[5] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 1, 5 => 3, 6 => 1, 7 => 2, 8 => 2, 9 => 2 },
    SCHEMAS[6] => { 0 => 2, 1 => 2, 2 => 2, 3 => 2, 4 => 1, 5 => 3, 6 => 2, 7 => 1, 8 => 2, 9 => 1 },
    SCHEMAS[7] => { 0 => 2, 1 => 1, 2 => 2, 3 => 1, 4 => 2, 5 => 4, 6 => 2, 7 => 1, 8 => 2, 9 => 1 },
    SCHEMAS[8] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 2, 5 => 4, 6 => 1, 7 => 1, 8 => 2, 9 => 1 },
    SCHEMAS[9] => { 0 => 2, 1 => 2, 2 => 2, 3 => 1, 4 => 2, 5 => 4, 6 => 2, 7 => 1, 8 => 1, 9 => 1 },
    SCHEMAS[10] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 2, 5 => 3, 6 => 2, 7 => 1, 8 => 2, 9 => 1 },
    SCHEMAS[11] => { 0 => 2, 1 => 1, 2 => 2, 3 => 2, 4 => 1, 5 => 3, 6 => 2, 7 => 2, 8 => 2, 9 => 1 },
    SCHEMAS[12] => { 0 => 2, 1 => 1, 2 => 2, 3 => 2, 4 => 2, 5 => 3, 6 => 1, 7 => 1, 8 => 2, 9 => 2 },
    SCHEMAS[13] => { 0 => 2, 1 => 2, 2 => 2, 3 => 1, 4 => 2, 5 => 3, 6 => 1, 7 => 2, 8 => 2, 9 => 1 },
    SCHEMAS[14] => { 0 => 2, 1 => 2, 2 => 2, 3 => 1, 4 => 2, 5 => 3, 6 => 2, 8 => 4 },
    SCHEMAS[15] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 2, 5 => 4, 6 => 1, 8 => 4 },
    SCHEMAS[16] => { 0 => 2, 1 => 2, 2 => 3, 3 => 1, 4 => 1, 5 => 3, 6 => 1, 7 => 2, 8 => 2, 9 => 1 },
    SCHEMAS[17] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 1, 5 => 3, 6 => 1, 7 => 2, 8 => 3, 9 => 1 },
    SCHEMAS[18] => { 0 => 2, 1 => 1, 2 => 3, 3 => 1, 4 => 1, 5 => 2, 6 => 1, 7 => 2, 8 => 3, 9 => 2 }
  }

  def initialize(team)
    @team = team
  	@main_country_id = team.country_id
    @numbers = []
  end

  def generate
    schema = SCHEMAS[rand(19)]
    pl_positions = (schema.length == 10 ? (0..9).to_a : [0, 1, 2, 3, 4, 5, 6, 8])
    players_count_main = 0 # д.б. 13
    players_count_foreigners = 0 # д.б. 5
    footballers_positions = FOOTBALLERS_POSITIONS[schema]
    footballers_positions.each do |pos, count|
      count.times do
        # рандомный выбор по странам игроков в порядке - по позициям
        chance = rand(100)
        if chance > 76 && players_count_foreigners < 5 || players_count_main == 13
          k = rand(252) + 1
          while k == @main_country_id
            k = rand(252) + 1
          end
          pl_c_id = k
          players_count_foreigners += 1
        elsif chance <= 76 && players_count_main < 13 || players_count_foreigners == 5
          pl_c_id = @main_country_id
          players_count_main += 1
        end
        random_player(pos, pl_c_id, @team.id)
      end
    end
    return
  end

  private

  def random_player(position, country_id, team_id)
    begin
      pl = Player.new
      pl.team_id = team_id
      pl.country_id = country_id
      pl.name = Name.new(country_id).rand_name
      pl.position1 = position || rand(PlayerGenerator::POS.size)
      pl.state = 1
      pl.basic = false
      pl.talent = PlayerGenerator.rand_talent
      pl.age = PlayerGenerator.rand_age(pl.talent)
      pl.skill_level = PlayerGenerator.rand_skill_level(pl.talent)
      pl.number = PlayerGenerator.rand_number(@numbers)
      @numbers << pl.number
      pl.save!
      pl
      #TODO pl.basic
    rescue ActiveRecord::RecordInvalid
      pl.name = Name.new(country_id).rand_name
      pl.save!
      return pl
    end
  end
end