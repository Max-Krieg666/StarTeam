class RandomTeam
  # класс для рандомизации команды
  SCHEMAS = [
    '4-4-2>1', '4-4-2>2', '4-4-2>3', '4-4-2>4',
    '4-3-3>1', '4-3-3>2', '4-3-3>3',
    '3-5-2>1', '3-5-2>2', '3-5-2>3',
    '3-4-3>1', '3-4-3>2', '3-4-3>3', '3-4-3>4', '3-4-3>5', '3-4-3>6',
    '4-2-4>1', '4-2-4>2', '4-2-4>3'
  ]

  FOOTBALLERS_POSITIONS = {
  	SCHEMAS[0] => { 0: 2, 1: 1, 2: 3, 3: 2, 4: 1, 5: 3, 6: 2, 7: 1, 8: 2, 9: 1 },
  	SCHEMAS[1] => { 0: 2, 1: 2, 2: 3, 3: 1, 4: 2, 5: 3, 6: 1, 7: 1, 8: 2, 9: 1 },
  	SCHEMAS[2] => { 0: 2, 1: 2, 2: 3, 3: 1, 4: 2, 5: 3, 6: 2, 8: 3 },
  	SCHEMAS[3] => { 0: 2, 1: 2, 2: 3, 3: 2, 4: 2, 5: 3, 6: 1, 8: 3 }
    SCHEMAS[4] => { 0: 2, 1: 1, 2: 3, 3: 2, 4: 2, 5: 3, 6: 1, 7: 1, 8: 2, 9: 1 },
    SCHEMAS[5] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 1, 5: 3, 6: 1, 7: 2, 8: 2, 9: 2 },
    SCHEMAS[6] => { 0: 2, 1: 2, 2: 2, 3: 2, 4: 1, 5: 3, 6: 2, 7: 1, 8: 2, 9: 1 },
    SCHEMAS[7] => { 0: 2, 1: 1, 2: 2, 3: 1, 4: 2, 5: 4, 6: 2, 7: 1, 8: 2, 9: 1 },
    SCHEMAS[8] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 2, 5: 4, 6: 1, 7: 1, 8: 2, 9: 1 },
    SCHEMAS[9] => { 0: 2, 1: 2, 2: 2, 3: 1, 4: 2, 5: 4, 6: 2, 7: 1, 8: 1, 9: 1 },
    SCHEMAS[10] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 2, 5: 3, 6: 2, 7: 1, 8: 2, 9: 1 },
    SCHEMAS[11] => { 0: 2, 1: 1, 2: 2, 3: 2, 4: 1, 5: 3, 6: 2, 7: 2, 8: 2, 9: 1 },
    SCHEMAS[12] => { 0: 2, 1: 1, 2: 2, 3: 2, 4: 2, 5: 3, 6: 1, 7: 1, 8: 2, 9: 2 },
    SCHEMAS[13] => { 0: 2, 1: 2, 2: 2, 3: 1, 4: 2, 5: 3, 6: 1, 7: 2, 8: 2, 9: 1 },
    SCHEMAS[14] => { 0: 2, 1: 2, 2: 2, 3: 1, 4: 2, 5: 3, 6: 2, 8: 4 },
    SCHEMAS[15] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 2, 5: 4, 6: 1, 8: 4 },
    SCHEMAS[16] => { 0: 2, 1: 2, 2: 3, 3: 1, 4: 1, 5: 3, 6: 1, 7: 2, 8: 2, 9: 1 },
    SCHEMAS[17] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 1, 5: 3, 6: 1, 7: 2, 8: 3, 9: 1 },
    SCHEMAS[18] => { 0: 2, 1: 1, 2: 3, 3: 1, 4: 1, 5: 2, 6: 1, 7: 2, 8: 3, 9: 2 }
  }

  def initialize(team)
  	main_country_id = team.country_id
    schema = SHEMAS[rand(19)]
    players = []
    players_count_main = 0 # д.б. 13
    players_count_foreigners = 0 # д.б. 5
    footballers_positions = FOOTBALLERS_POSITIONS[schema]
    footballers_positions.each do |pos, count|
      #TODO тут написать метод выбора страны set_country
      count.times do
        players << random_player(pos, main_country_id, team.id)
      end
    end
  end

  private

  def random_player(position, country_id, team_id)
    pl = Player.new
    pl.team_id = team_id
    pl.country_id = country_id
    pl.name = Name.new(country_id).rand_name
    pl.position1 = position || PlayerGenerator::POS[rand(PlayerGenerator::POS.size)]
    pl.position2 = ''
    pl.state = 1
    pl.basic = false
    pl.talent = PlayerGenerator.rand_talent
    pl.age = PlayerGenerator.rand_age
    pl.skill_level = PlayerGenerator.rand_skill_level
    pl.price = (pl.talent * pl.skill_level * 10000 / pl.age).round(3)
    pl
  end

  def set_country

  end
end