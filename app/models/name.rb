class Name
	# TODO доделать эту заготовку генерации!!!
  attr_accessor :fullname, :firstname, :prefix, :lastname, :country_id

  def initialize(country_id)
  	@country_id = country_id
  end

  def rand_name
    
  end

  def parse_file

  end

  def define_file
  	file_names = nil
  	file_lastnames = nil
    case @country_id
    when 239, 1, 7, 10, 15, 17, 20, 23
      # Англия, Австралия, Ангилья, Антигуа и Барбуда, Багамы, Барбадос, Белиз, Бермуды
      file_names = 'english'
      file_lastnames = 'english'
    when 2
      # Австрия
      file_names = 'austrian'
      file_lastnames = 'austrian'
    when 3
      # Азербайджан
      file_names = 'azerbaijanian'
      file_lastnames = 'azerbaijanian'
    when 4
      # Албания
      file_names = 'albanian'
      file_lastnames = 'albanian'
    when 5
      # Алжир
      file_names = 'algerian'
      file_lastnames = 'algerian'
    when 6, 165
      # Американское Самоа, США
      file_names = 'american'
      file_lastnames = 'american'
    when 8, 29, 159
      # Ангола, Бразилия, Португалия
      file_names = 'portuguese'
      file_lastnames = 'portuguese'
    when 9, 11, 79
      # Андорра, Аргентина, Испания
      file_names = 'spain'
      file_lastnames = 'spain'
    when 12
      # Армения
      file_names = 'armenian'
      file_lastnames = 'armenian'
    when 13, 137
      # Аруба, Нидерланды
      file_names = 'dutch'
      file_lastnames = 'dutch'
    when 14
      # Афганистан
      file_names = 'afghan'
      file_lastnames = 'afghan'
    when 16
      # Бангладеш TODO!!!
      file_names = '???'
      file_lastnames = '???'
    when 18, 99, 143, 144
      # Бахрейн, Кувейт, Объединенные Арабские Эмираты, Оман
      file_names = 'arabic'
      file_lastnames = 'arabic'
    when 19
      # Беларусь
      file_names = 'russian'
      file_lastnames = 'belarus'
    when 19
      # Беларусь
      file_names = 'russian'
      file_lastnames = 'belarus'
    when 21
      # Бельгия
      file_names = 'belgian'
      file_lastnames = 'belgian'
    when 22
      # Бенин TODO!!!
      file_names = '???'
      file_lastnames = '???'
    when 24
      # Болгария
      file_names = 'bulgarian'
      file_lastnames = 'bulgarian'
    when 140
      # Новая Зеландия
      file_names = 'maori'
      file_lastnames = 'maori'
    when 148
      # Острова Кука
      file_names = 'maori'
      file_lastnames = 'cook_islands'
    else

    end

    file_names += '_names.yml'
    file_lastnames += '_lastnames.yml'
  end
end
