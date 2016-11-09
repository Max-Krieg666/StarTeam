if Country.count.zero?
  ActiveRecord::Base.transaction do
    YAML::load_file(Rails.root.join('db', 'seeds', 'countries.yml')).each do |country|
      c = Country.new(country)
      begin
        c.flag = File.new(Rails.root.join('flags', 'flags', 'shiny', '24', "#{c.title}.png"))
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
