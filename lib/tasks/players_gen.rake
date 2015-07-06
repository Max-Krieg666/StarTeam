require File.expand_path(File.dirname(__FILE__) + "/bd1.rb")
require File.expand_path(File.dirname(__FILE__) + "/bd2.rb")
require File.expand_path(File.dirname(__FILE__) + "/bd3.rb")
DEF=20

desc "Создание #{DEF} различных игроков"
namespace :players do
  task :create=>:environment do
    DEF.times do
      x=rand(38)+1
      pl=Player.new
      pl.position1=@pos[rand(@pos.size)]
      pl.position2=""
      pl.talent=rand(1..9) # переделать
      pl.age=rand(17..39) # переделать
      pl.skill_level=rand(10..80) # переделать
      pl.price=pl.talent*pl.skill_level*10000/pl.age
      case x
      when 1,5,10,12,23 #Россия
        name=@rus_names[rand(@rus_names.size)]
        lastname=@rus_lastnames[rand(@rus_lastnames.size)]
        pl.name="#{name} #{lastname}"
        pl.country_id=160
      when 2,13,24 #Англия
        name=@eng_names[rand(@eng_names.size)]
        lastname=@eng_lastnames[rand(@eng_lastnames.size)]
        pl.name="#{name} #{lastname}"
        pl.country_id=237
      #when 3,25 #Ирландия
      else
        name=@irl_names[rand(@irl_names.size)]
        lastname=@irl_lastnames[rand(@irl_lastnames.size)]
        pl.name="#{name} #{lastname}"
        pl.country_id=75
      #else
      end
      pl.save!
    end
    # pls=
    # us1=User.create(login: "Admin", password: "administrator",
    #                 mail: "admin@test.ru", sex: 'м', role: 2)
    # us2=User.create(login: "Moderator", password: "moderator",
    #                 mail: "moder@test.ru", sex: 'м', role: 1)
    # us3=User.create(login: "UserTest", password: "usertest",
    #                 mail: "user@test.ru", sex: 'м', role: 0)
  end
end