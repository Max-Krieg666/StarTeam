namespace :users do
  desc 'Создание N пользователей для страны C'
  task :create, [:count, :country_id] => :environment do |_task, args|
    count = args[:count].to_i
    country = Country.find(args[:country_id])
    puts "Создаём #{count} пользователей и команд в стране #{country.i18n_title}"
    count.times do
      ActiveRecord::Base.transaction do
        login = Faker::Internet.username
        email = Faker::Internet.email
        user_params = {
          login: login,
          email: email,
          password: email,
          password_confirmation: email,
          role: :user,
          country_id: country.id
        }

        @user = User.create!(user_params)
        team_name = "FC #{login.capitalize} #{Faker::Creature::Animal.name.capitalize}s"
        team_params = { title: team_name, country_id: country.id }
        CreateNewTeamService.perform(@user, team_attributes: team_params)
        puts "#{@user.login} =>> #{team_name}"
      end
    rescue => e
      puts "Failed with #{e.message}"
      next
    end
    puts 'OK!'
  end
end
