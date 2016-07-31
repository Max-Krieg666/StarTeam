Rails.root.join('lib', 'tasks', 'bd3')

ActiveRecord::Base.transaction do
  @c1 += ['Абхазия', 'Аланд', 'Англия', 'Канарские острова',
    'Кокосовые острова (Килинг)', 'Майотта', 'Нидерландские Антиллы',
    'Остров Рождества', 'Уэльс', 'Сен-Бартельми',
    'Северная Ирландия', 'Северный Кипр', 'Сомалиленд', 'Шотландия',
    'Южная Осетия', 'Южная Георгия и Южные Сандвичевы Острова']

  for i in 0...@c1.size
    c = Country.new(title: @c1[i])
    begin
      c.flag = File.new(Rails.root.join('flags', 'flags', 'shiny', '24', "#{@c1[i]}.png"))
    rescue
      c.flag = File.new(Rails.root.join('flags', 'flags', 'shiny', '24', 'Unknown.png'))
    end
    c.save!
  end

  puts "Стран создано: #{Country.count}"
end

# Игроки
ActiveRecord::Base.transaction do
  YAML::load_file(Rails.root.join('db', 'seeds', 'players-data-1.yml')).each do |player_params|
    Player.create!(player_params)
  end
  puts "Игроков создано: #{Player.count}"
end
