desc 'Создание 3 пользователей с разными правами'
namespace :users do
  task create: :environment do
    print '3 users_create: '
    User.create!(login: 'Admin', password: 'administrator',
                email: 'admin@test.ru', sex: 1, role: 2)
    print '. '
    User.create!(login: 'Moderator', password: 'moderator',
                email: 'moder@test.ru', sex: 1, role: 1)
    print '. '
    User.create!(login: 'UserTest', password: 'usertest',
                email: 'user@test.ru', sex: 1, role: 0)
    print '. '
    puts 'OK!'
  end
end
