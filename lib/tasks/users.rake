desc "Создание 3 пользователей с разными правами"
namespace :users do
  task :create=>:environment do
    print '3 players_create: '
    User.create(login: "Admin", password: "administrator",
                mail: "admin@test.ru", sex: 'м', role: 2)
    print '. '
    User.create(login: "Moderator", password: "moderator",
                mail: "moder@test.ru", sex: 'м', role: 1)
    print '. '
    User.create(login: "UserTest", password: "usertest",
                mail: "user@test.ru", sex: 'м', role: 0)
    print '. '
    puts 'OK!'
  end
end