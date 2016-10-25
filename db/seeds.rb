Rails.root.join('lib', 'tasks', 'bd3')

if Country.count.zero?
  ActiveRecord::Base.transaction do
    @c1.each do |id, item|
      c = Country.new(id: id, title: item)
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
