desc "Генерация 77 спонсоров"

namespace :sponsor do
  task :create=>:environment do
    77.times do |t|
      xs=["Fram_Reykjavik","Oleg_Dm","FC Olenegrad"]
      sp=Sponsor.new(title:"Sponsor-Test#{t+1}",
                     specialization: "SpezTest#{rand(555)-rand(300)}",
                     sponsorship: xs[rand(xs.size)]+"#{t}",
                     loyalty_factor: 1.0,
                     cost_of_full_stake: rand(10000000))
      sp.win_prize=sp.cost_of_full_stake/1000.0
      sp.draw_prize=sp.cost_of_full_stake/2000.0
      sp.lost_prize=sp.cost_of_full_stake/8000.0
      sp.save!
    end
  end
end
