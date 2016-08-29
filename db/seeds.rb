Rails.root.join('lib', 'tasks', 'bd3')

if Country.count.zero?
  ActiveRecord::Base.transaction do
    @c1 += ['Абхазия', 'Аланд', 'Англия', 'Канарские острова',
      'Кокосовые острова (Килинг)', 'Майотта', 'Нидерландские Антиллы',
      'Остров Рождества', 'Уэльс', 'Сен-Бартельми',
      'Северная Ирландия', 'Северный Кипр', 'Сомалиленд', 'Шотландия',
      'Южная Осетия', 'Южная Георгия и Южные Сандвичевы Острова'
    ]

    @c1.each do |item|
      c = Country.new(title: item)
      begin
        c.flag = File.new(Rails.root.join('flags', 'flags', 'shiny', '24', "#{item}.png"))
      rescue
        c.flag = File.new(Rails.root.join('flags', 'flags', 'shiny', '24', 'Unknown.png'))
      end
      c.save!
    end

    puts "Стран создано: #{Country.count}"
  end
end

# Игроки
ActiveRecord::Base.transaction do
  YAML::load_file(Rails.root.join('db', 'seeds', 'players-data-1.yml')).each do |player_params|
    Player.create!(player_params)
  end
  puts "Игроков создано: #{Player.count}"
end
