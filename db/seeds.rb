# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Страны
countries=HTTParty.get 'http://api.vk.com/method/database.getCountries?v=5.21&need_all=1&count=500'
c1=[]
countries['response']['items'].each do |attrs|
  c1<<Country.new(title: attrs['title'])
end
unknown=File.new("#{Rails.root}/flags/flags/shiny/24/Unknown.png")
for i in 0...c1.size
  begin
    flag=File.new("#{Rails.root}/flags/flags/shiny/24/#{c1[i].title}.png")
    c1[i].flag=flag
  rescue
    c1[i].flag=unknown
  end
  c1[i].save!
end

Country.create(title: "Абхазия", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Абхазия.png"))
Country.create(title: "Аланд", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Аланд.png"))
Country.create(title: "Англия", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Англия.png"))
Country.create(title: "Гернси", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Гернси.png"))
Country.create(title: "Джерси", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Джерси.png"))
Country.create(title: "Канарские острова", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Канарские острова.png"))
Country.create(title: "Кокосовые острова (Килинг)", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Кокосовые острова (Килинг).png"))
Country.create(title: "Майотта", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Майотта.png"))
Country.create(title: "Нидерландские Антиллы", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Нидерландские Антиллы.png"))
Country.create(title: "Остров Рождества", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Остров Рождества.png"))
Country.create(title: "Уэльс", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Уэльс.png"))
Country.create(title: "Сен-Бартельми", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Сен-Бартельми.png"))
Country.create(title: "Северная Ирландия", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Северная Ирландия.png"))
Country.create(title: "Северный Кипр", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Северный Кипр.png"))
Country.create(title: "Сомалиленд", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Сомалиленд.png"))
Country.create(title: "Шотландия", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Шотландия.png"))
Country.create(title: "Южная Осетия", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Южная Осетия.png"))
Country.create(title: "Южная Георгия и Южные Сандвичевы Острова", :flag=> File.new("#{Rails.root}/flags/flags/shiny/24/Южная Георгия и Южные Сандвичевы Острова.png"))