desc "Создание 3 пользователей с разными правами"
namespace :users do
  task :create=>:environment do
    us1=User.create(login: "Admin", password: "administrator",
                     mail: "admin@test.ru", sex: 'м', role: 2)
    us2=User.create(login: "Moderator", password: "moderator",
                     mail: "moder@test.ru", sex: 'м', role: 1)
    us3=User.create(login: "UserTest", password: "usertest",
                     mail: "user@test.ru", sex: 'м', role: 0)
  end
end