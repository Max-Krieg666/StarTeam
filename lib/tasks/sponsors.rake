DEF = 30

desc "Генерация #{DEF} спонсоров"

namespace :sponsors do
  task create: :environment do
    print "#{DEF} sponsors_create: "
    DEF.times do |t|
      sp = Sponsor.new(title: "Sponsor-Test#{t + 1}",
                       specialization: "SpezTest#{rand(555) - rand(300)}",
                       loyalty_factor: 1.0,
                       cost_of_full_stake: rand(10000000) + 100000)
      sp.win_prize = sp.cost_of_full_stake / 1000.0
      sp.draw_prize = sp.cost_of_full_stake / 2000.0
      sp.lost_prize = sp.cost_of_full_stake / 8000.0
      sp.save!
      print "#{t + 1} -> "
    end
    puts 'OK!'
  end
end
# TODO переписать использую стандартный гем)