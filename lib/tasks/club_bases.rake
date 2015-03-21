desc "Генерация 29 баз"

namespace :club_base do
  task :create=>:environment do
    29.times do |t|
      xs=["Fram_Reykjavik","Oleg_Dm","FC Olenegrad"]
      xx=["Visus Exesus","Lores Ipsum","Le nieste"]
      cb=ClubBase.new(owner: xs[rand(xs.size)]+"#{t}",
                      title: xx[rand(xx.size)]+"#{t}",
                      level: 1, capacity: 20, training_fields: 1, experience_up: 0.1)
      cb.save!
    end
  end
end
