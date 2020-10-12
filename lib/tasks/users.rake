desc 'Создание 2 пользователей с разными правами'
namespace :users do
  task create: :environment do
    print '2 users_create: '
    User.create!(
      login: 'Main_admin', password: 'administrator', password_confirmation: 'administrator',
      email: 'admin@testing-ts.ru', sex: 1, role: 2, country_id: 1
    )
    print '. '
    User.create!(
      login: 'Moderator', password: 'moderator', password_confirmation: 'moderator',
      email: 'moder@testing-ts.ru', sex: 1, role: 1, country_id: 1
    )
    print '. '
    puts 'OK!'
  end
end
