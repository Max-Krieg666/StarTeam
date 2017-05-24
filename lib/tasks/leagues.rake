desc 'ПЕРВОНАЧАЛЬНОЕ (!) Создание лиг и кубков для каждой страны (!)'
namespace :leagues do
  task create: :environment do
    print 'start creating... leagues for countries'
    Country.each do |country|
      League.create!(
        country_id: country.id,
        count: 0,
        title: 'premier'
      )
      League.create!(
        country_id: country.id,
        count: 0,
        title: 'div1'
      )
      Cup.create!(
        country_id: country.id,
        count: 0,
        title: 'national'
      )
    end
    puts 'OK!'
  end
end
