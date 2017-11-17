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
