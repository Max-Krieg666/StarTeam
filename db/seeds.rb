if Country.count.zero?
  ActiveRecord::Base.transaction do
    YAML::load_file(Rails.root.join('db', 'seeds', 'countries.yml')).each do |country|
      c = Country.new(country)
      begin
        c.flag = File.new(Rails.root.join('app', 'assets', 'images', 'flags', "#{c.title}.png"))
      rescue
        c.flag = File.new(Rails.root.join('app', 'assets', 'images', 'flags', 'Unknown.png'))
      end
      c.save!
    end

    puts "Стран создано: #{Country.count}"
  end
end

# Игроки
ActiveRecord::Base.transaction do
  Dir[Rails.root.join('db', 'seeds', 'players', '*.yml')].each do |file|
    YAML::load_file(file).each do |player_params|
      p = Player.new(player_params)
      Generator::RandomCharacteristics.new(p).randomize.save!
    end
  end
  puts "Игроков создано: #{Player.count}"
end

# Схемы
ActiveRecord::Base.transaction do
  Dir[Rails.root.join('db', 'seeds', 'formations.yml')].each do |file|
    YAML::load_file(file).each do |formation_params|
      Formation.create(formation_params)
    end
  end
  puts "Схем создано: #{Formation.count}"
end

User.create([{
    login: 'Main_admin', password: 'administrator', password_confirmation: 'administrator',
    email: 'admin@testing-ts.ru', sex: 1, role: 2, country_id: 1
  }, {
    login: 'Moderator', password: 'moderator', password_confirmation: 'moderator',
    email: 'moder@testing-ts.ru', sex: 1, role: 1, country_id: 1
  }]
)

puts "Пользователей создано: #{User.count}"
