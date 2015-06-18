# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Страны
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
# Игроки
players=Player.create([{name: "Зотарри Саид-Шах", country_id: 142, position1: 'Lm', position2: '', talent: 4, age: 25, skill_level: 44, price:4*44*10000/25.0},
                       {name: "Донован Йоваль", country_id: 188, position1: 'Rf', position2: '', talent: 4, age: 21, skill_level: 35, price:4*35*10000/21.0},
                       {name: "Мате Крньятич", country_id: 215, position1: 'Rf', position2: '', talent: 9, age: 21, skill_level: 106, price:9*106*10000/21.0},
                       {name: "Хьетилль Гродал", country_id: 140, position1: 'Cf', position2: '', talent: 7, age: 22, skill_level: 47, price:7*47*10000/22.0},
                       {name: "Рами Вильхельмссон", country_id: 222, position1: 'Cf', position2: '', talent: 6, age: 25, skill_level: 48, price:115200.0},
                       {name: "Рами Тангрём", country_id: 222, position1: 'Cf', position2: '', talent: 3, age: 17, skill_level: 45, price:3*45*10000/17.0},
                       {name: "Даг Роттербю", country_id: 222, position1: 'Ld', position2: '', talent: 2, age: 35, skill_level: 39, price:2*39*10000/35.0},
                       {name: "Павел Собре", country_id: 237, position1: 'Lf', position2: '', talent: 5, age: 18, skill_level: 67, price:5*67*10000/18.0},
                       {name: "Макс Борн", country_id: 237, position1: 'Ld', position2: '', talent: 8, age: 17, skill_level: 31, price:8*31*10000/17.0},
                       {name: "Бен Рэйли", country_id: 237, position1: 'Ld', position2: '', talent: 2, age: 27, skill_level: 44, price:2*44*10000/27.0},
                       {name: "Джон Констэбл", country_id: 237, position1: 'Ld', position2: '', talent: 3, age: 37, skill_level: 45, price:3*45*10000/37.0},
                       {name: "Лэнгстон Хьюдж", country_id: 237, position1: 'Ld', position2: '', talent: 9, age: 20, skill_level: 76, price:9*76*10000/20.0},
                       {name: "Робин ван дер Платт", country_id: 135, position1: 'Cf', position2: '', talent: 5, age: 22, skill_level: 34, price:5*34*10000/22.0},
                       {name: "Даниэль Бара Монцело", country_id: 157, position1: 'Ld', position2: '', talent: 8, age: 30, skill_level: 60, price:160000.0},
                       {name: "Анхель Сан Гильман", country_id: 122, position1: 'Cd', position2: '', talent: 2, age: 22, skill_level: 57, price:2*57*10000/22.0},
                       {name: "Жак Икс", country_id: 108, position1: 'Rm', position2: '', talent: 5, age: 22, skill_level: 33, price:75000.0},
                       {name: "Феликс Аурейро", country_id: 29, position1: 'Сm', position2: '', talent: 9, age: 21, skill_level: 88, price:9*88*10000/21.0},
                       {name: "Алессандро Барбосса Эстевез", country_id: 29, position1: 'Сm', position2: '', talent: 9, age: 18, skill_level: 122, price:610000.0},
                       {name: "Давид Нурдквист", country_id: 222, position1: 'Lm', position2: '', talent: 8, age: 18, skill_level: 120, price:8*120*10000/18.0},
                       {name: "Фрэнк Юнг", country_id: 163, position1: 'Lm', position2: '', talent: 7, age: 18, skill_level: 64, price:7*64*10000/18.0},
                       {name: "Нильс Грав", country_id: 197, position1: 'Gk', position2: '', talent: 2, age: 38, skill_level: 26, price:2*26*10000/38.0},
                       {name: "Серхио Суарез", country_id: 77, position1: 'Gk', position2: '', talent: 5, age: 18, skill_level: 33, price:5*33*10000/18.0},
                       {name: "Борхе Табрадала", country_id: 77, position1: 'Cd', position2: '', talent: 7, age: 24, skill_level: 63, price: 183750.0},
                       {name: "Херардо Вилья", country_id: 77, position1: 'Gk', position2: '', talent: 8, age: 22, skill_level: 78, price:8*78*10000/22.0},
                       {name: "Талель Шайлен", country_id: 212, position1: 'Gk', position2: '', talent: 6, age: 27, skill_level: 42, price:6*42*10000/27.0},
                       {name: "Тимо Шнайдер", country_id: 52, position1: 'Gk', position2: '', talent: 9, age: 20, skill_level: 68, price:306000.0},
                       {name: "Томас Хенниг Вессен", country_id: 61, position1: 'Gk', position2: '', talent: 6, age: 36, skill_level: 66, price:110000.0},
                       {name: "Хендрик Николссон", country_id: 222, position1: 'Gk', position2: '', talent: 4, age: 32, skill_level: 64, price:80000.0},
                       {name: "Халид-Буханджар Ариби", country_id: 5, position1: 'Gk', position2: '', talent: 5, age: 27, skill_level: 39, price:5*39*10000/27.0},
                       {name: "Уилфред Гоуп", country_id: 107, position1: 'Gk', position2: '', talent: 3, age: 32, skill_level: 38, price:3*38*10000/32.0},
                       {name: "Салем Хамис Башир", country_id: 141, position1: 'Ld', position2: '', talent: 7, age: 25, skill_level: 62, price:7*62*10000/25.0},
                       {name: "Эрик Лейне Халльдорсен", country_id: 140, position1: 'Ld', position2: '', talent: 7, age: 29, skill_level: 53, price:7*53*10000/29.0},
                       {name: "Кирилл Дроздов", country_id: 125, position1: 'Cd', position2: '', talent: 7, age: 29, skill_level: 49, price:7*49*10000/29.0},
                       {name: "Бранимир Петринич", country_id: 27, position1: 'Cd', position2: '', talent: 7, age: 27, skill_level: 54, price:140000.0},
                       {name: "Горав Хиши", country_id: 132, position1: 'Cd', position2: '', talent: 2, age: 29, skill_level: 32, price:2*32*10000/29.0},
                       {name: "Герхард Седерберг", country_id: 222, position1: 'Rd', position2: '', talent: 5, age: 31, skill_level: 46, price:5*46*10000/31.0},
                       {name: "Фредрик Клинберг", country_id: 140, position1: 'Rd', position2: '', talent: 3, age: 32, skill_level: 32, price:30000.0},
                       {name: "Томас Бо Ханссен", country_id: 61, position1: 'Ld', position2: '', talent: 5, age: 35, skill_level: 68, price:5*68*10000/35.0},
                       {name: "Мигель Дэлиа", country_id: 118, position1: 'Lm', position2: '', talent: 5, age: 20, skill_level: 50, price:125000.0},
                       {name: "Гилермо Эскалада Супреза", country_id: 206, position1: 'Cm', position2: '', talent: 8, age: 31, skill_level: 67, price:8*67*10000/31.0},
                       {name: "Ван Пак-Чон", country_id: 171, position1: 'Cm', position2: '', talent: 5, age: 28, skill_level: 56, price:100000.0},
                       {name: "Джон Сорокатини", country_id: 208, position1: 'Cm', position2: '', talent: 3, age: 28, skill_level: 34, price:3*34*10000/28.0},
                       {name: "Сунил Такхла", country_id: 208, position1: 'Cm', position2: '', talent: 1, age: 31, skill_level: 31, price:10000.0},
                       {name: "Монеш Ралулу", country_id: 208, position1: 'Rf', position2: '', talent: 3, age: 30, skill_level: 30, price: 30000.0},
                       {name: "Фредерик Фоксвелл", country_id: 57, position1: 'Rm', position2: '', talent: 7, age: 70, skill_level: 37, price:7*70*10000/37.0},
                       {name: "Клебер Форталеза Гонзалез", country_id: 94, position1: 'Rm', position2: '', talent: 7, age: 25, skill_level: 55, price:7*55*10000/25.0},
                       {name: "Хуарез Кристиш", country_id: 94, position1: 'Lm', position2: '', talent: 6, age: 24, skill_level: 37, price:6*37*10000/24.0},
                       {name: "Хуарез Милито", country_id: 94, position1: 'Cm', position2: '', talent: 5, age: 28, skill_level: 47, price:5*47*10000/28.0},
                       {name: "Борис Шрайбман", country_id: 69, position1: 'Cm', position2: '', talent: 6, age: 29, skill_level: 44, price:6*44*10000/29.0},
                       {name: "Илиа Йединак", country_id: 219, position1: 'Cm', position2: '', talent: 4, age: 26, skill_level: 63, price: 96923.077},
                       {name: "Милош Годвал", country_id: 219, position1: 'Lm', position2: '', talent: 2, age: 28, skill_level: 38, price: 27142.857},
                       {name: "Алаин Мартинез", country_id: 220, position1: 'Rm', position2: '', talent: 7, age: 18, skill_level: 26, price: 101111.111},
                       {name: "Йенкун Ло Сунь", country_id: 89, position1: 'Rd', position2: '', talent: 3, age: 36, skill_level: 50, price: 41666.667},
                       {name: "Ба Гуань", country_id: 89, position1: 'Cm', position2: '', talent: 8, age: 22, skill_level: 57, price: 207272.727},
                       {name: "Силжу Нулинь", country_id: 89, position1: 'Rf', position2: '', talent: 2, age: 25, skill_level: 34, price: 27200.0},
                       {name: "Квинг Ксяоджиа", country_id: 89, position1: 'Cd', position2: '', talent: 6, age: 19, skill_level: 57, price: 180000.0},
                       {name: "Исам Гафни", country_id: 199, position1: 'Cd', position2: '', talent: 5, age: 18, skill_level: 30, price: 83333.333},
                       {name: "Заулхиссам Сабри", country_id: 115, position1: 'Lm', position2: '', talent: 5, age: 18, skill_level: 33, price: 91666.667},
                       {name: "Франческо Эль Франко", country_id: 122, position1: 'Gk', position2: '', talent: 7, age: 19, skill_level: 83, price: 305789.474},
                       {name: "Леон ван дер Хайзе", country_id: 135, position1: '', position2: '', talent: 1, age: 23, skill_level: 57, price: 24782.609},
                       {name: "Маркос Нова", country_id: 206, position1: 'Rf', position2: '', talent: 8, age: 31, skill_level: 61, price: 157419.355},
                       {name: "Людовик Слобода", country_id: 219, position1: 'Cf', position2: '', talent: 4, age: 26, skill_level: 51, price: 78461.538},
                       {name: "Ричард Мансон", country_id: 75, position1: 'Cd', position2: '', talent: 4, age: 37, skill_level: 34, price: 36756.757},
                       {name: "Джунг Тан Синх", country_id: 55, position1: 'Cm', position2: '', talent: 3, age: 19, skill_level: 28, price:3*28*10000/19.0},
                       {name: "Хальвор Минесберг", country_id: 207, position1: 'Lf', position2: '', talent: 3, age: 34, skill_level: 56, price:3*56*10000/34.0},
                       {name: "Эйнар Кристьян Йоханссон", country_id: 76, position1: 'Cf', position2: '', talent: 7, age: 28, skill_level: 62, price:155000.0},
                       {name: "Снефф Гнупсон", country_id: 76, position1: 'Gk', position2: '', talent: 7, age: 35, skill_level: 76, price:152000.0},
                       {name: "Андреа Ивокини", country_id: 78, position1: 'Gk', position2: '', talent: 8, age: 20, skill_level: 60, price:240000.0},
                       {name: "Кристофер Уинкинг", country_id: 84, position1: 'Ld', position2: '', talent: 5, age: 23, skill_level: 51, price:5*51*10000/23.0},
                       {name: "Петерс Якхольм", country_id: 210, position1: 'Cf', position2: '', talent: 3, age: 32, skill_level: 38, price:3*38*10000/32.0},
                       {name: "Мигель Дэлиа", country_id: 118, position1: 'Lm', position2: '', talent: 5, age: 20, skill_level: 50, price: 125000.0},
                       {name: "Рене Мише", country_id: 108, position1: 'Rm', position2: '', talent: 1, age: 35, skill_level: 31, price: 8857.143},
                       {name: "Леннарт Бугденс", country_id: 222, position1: 'Cd', position2: '', talent: 2, age: 33, skill_level: 39, price: 23636.364},
                       {name: "Севеци Амброзо", country_id: 208, position1: 'Rf', position2: '', talent: 8, age: 34, skill_level: 61, price:8*61*10000/34.0}])