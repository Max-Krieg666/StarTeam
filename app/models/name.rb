class Name
  # TODO доделать эту заготовку генерации!!!
  attr_accessor :fullname, :firstname, :prefix, :lastname, :country_id

  def initialize(country_id)
    @country_id = country_id
  end

  def rand_name
    files = define_file
    file1 = YAML.load_file(Rails.root.join('lib', 'names', files[0]))
    file2 = YAML.load_file(Rails.root.join('lib', 'lastnames', files[1]))
    name = file1[rand(file1.size)] + ' ' + file2[rand(file2.size)]
    name
  end

  def define_file
    file_names = nil
    file_lastnames = nil
    case @country_id
    when 239, 1, 7, 10, 15, 17, 20, 23, 36, 39, 57, 65, 130, 145, 146, 147, 149
      # Англия, Австралия, Ангилья, Антигуа и Барбуда, Багамы, Барбадос, Белиз, Бермуды, Великобритания, Виргинские острова, Гренада, Доминика, Монтсеррат, Остров Мэн, Остров Норфолк, Острова Кайман, Острова Теркс и Кайкос
      file_names = 'english'
      file_lastnames = 'english'
    when 2
      # Австрия
      file_names = 'austrian'
      file_lastnames = 'austrian'
    when 3
      # Азербайджан
      file_names = 'azerbaijanian'
      file_lastnames = 'azerbaijanian'
    when 4
      # Албания
      file_names = 'albanian'
      file_lastnames = 'albanian'
    when 5
      # Алжир
      file_names = 'algerian'
      file_lastnames = 'algerian'
    when 6, 165, 40, 61
      # Американское Самоа, США, Британские, Виргинские острова, США, Гуам, 
      file_names = 'american'
      file_lastnames = 'american'
    when 8, 29, 51, 82, 159
      # Ангола, Бразилия, Гвинея-Бисау, Кабо-Верде, Португалия
      file_names = 'portuguese'
      file_lastnames = 'portuguese'
    when 9, 11, 38, 54, 66, 79, 92, 124
      # Андорра, Аргентина, Венесуэла, Гибралтар, Доминиканская Республика, Испания, Колумбия, Мексика
      file_names = 'spain'
      file_lastnames = 'spain'
    when 12
      # Армения
      file_names = 'armenian'
      file_lastnames = 'armenian'
    when 13, 26, 101, 137
      # Аруба, Бонайре, Синт-Эстатиус и Саба, Кюрасао, Нидерланды
      file_names = 'dutch'
      file_lastnames = 'dutch'
    when 14
      # Афганистан
      file_names = 'afghan'
      file_lastnames = 'afghan'
    when 16
      # Бангладеш
      file_names = 'bangladesh'
      file_lastnames = 'bangladesh'
    when 18, 74, 75, 81, 87, 99, 106, 143, 144
      # Бахрейн, Иордания, Ирак, Йемен, Катар, Кувейт, Ливан, Объединенные Арабские Эмираты, Оман
      file_names = 'arabic'
      file_lastnames = 'arabic'
    when 19
      # Беларусь
      file_names = 'russian'
      file_lastnames = 'belarus'
    when 19
      # Беларусь
      file_names = 'russian'
      file_lastnames = 'belarus'
    when 21
      # Бельгия
      file_names = 'belgian'
      file_lastnames = 'belgian'
    when 22
      # Бенин
      file_names = 'beninese'
      file_lastnames = 'beninese'
    when 24
      # Болгария
      file_names = 'bulgarian'
      file_lastnames = 'bulgarian'
    when 25
      # Боливия TODO!!!
      # file_names = 'bolivian'
      # file_lastnames = 'bolivian'
    when 27
      # Босния и Герцеговина
      file_names = 'bosnian'
      file_lastnames = 'bosnian'
    when 28
      # Ботсвана
      file_names = 'botswana'
      file_lastnames = 'botswana'
    when 30
      # Бруней-Даруссалам
      # file_names = 'brunei'
      # file_lastnames = 'brunei'
    when 31
      # Буркина-Фасо
      file_names = 'burkina_faso'
      file_lastnames = 'burkina_faso'
    when 32
      # Бурунди
      file_names = 'burundi'
      file_lastnames = 'burundi'
    when 33
      # Бутан
      # file_names = 'butan'
      # file_lastnames = 'butan'
    when 34
      # Вануату
      # file_names = 'vanuatu'
      # file_lastnames = 'vanuatu'
    when 35
      # Ватикан
      # file_names = 'vatican'
      # file_lastnames = 'vatican'
    when 37
      # Венгрия
      file_names = 'hungarian'
      file_lastnames = 'hungarian'
    when 41
      # Восточный Тимор
      # file_names = 'east_timor'
      # file_lastnames = 'east_timor'
    when 42
      # Вьетнам
      file_names = 'vietnamese'
      file_lastnames = 'vietnamese'
    when 43
      # Габон
      file_names = 'gabon'
      file_lastnames = 'gabon'
    when 44
      # Гаити
      # file_names = 'haiti'
      # file_lastnames = 'haiti'
    when 45
      # Гайана
      # file_names = 'hayana'
      # file_lastnames = 'hayana'
    when 46
      # Гамбия
      file_names = 'gambian'
      file_lastnames = 'gambian'
    when 47
      # Гана
      file_names = 'ghana'
      file_lastnames = 'ghana'
    when 48, 122, 128, 141, 214
      # Гваделупа, Мартиника, Монако, Новая Каледония, Франция
      file_names = 'french'
      file_lastnames = 'french'
    when 49
      # Гватемала
      # file_names = 'guatemala'
      # file_lastnames = 'guatemala'
    when 50
      # Гвинея
      file_names = 'guinean'
      file_lastnames = 'guinean'
    when 52, 109
      # Германия, Лихтенштейн
      file_names = 'german'
      file_lastnames = 'german'
    when 53, 63
      # Гернси, Джерси
      word = rand(100) > 49 ? 'english' : 'french'
      file_names = word
      file_lastnames = word
    when 55
      # Гондурас
      # file_names = 'honduras'
      # file_lastnames = 'honduras'
    when 56, 91, 114
      # Гонконг, Китай, Макао
      file_names = 'chinese'
      file_lastnames = 'chinese'
    when 58
      # Гренландия
      file_names = 'greenlandic'
      file_lastnames = 'greenlandic'
    when 59, 89, 248
      # Греция, Кипр, Северный Кипр
      file_names = 'greek'
      file_lastnames = 'greek'
    when 60
      # Грузия
      file_names = 'georgian'
      file_lastnames = 'georgian'
    when 62
      # Дания
      file_names = 'danish'
      file_lastnames = 'danish'
    when 64
      # Джибути
      file_names = 'djibouti'
      file_lastnames = 'djibouti'
    when 67
      # Египет
      file_names = 'egyptian'
      file_lastnames = 'egyptian'
    when 68
      # Замбия
      file_names = 'zambian'
      file_lastnames = 'zambian'
    when 69, 121
      # Западная Сахара, Марокко
      file_names = 'moroccanian'
      file_lastnames = 'moroccanian'
    when 70
      # Зимбабве
      file_names = 'zimbabwe'
      file_lastnames = 'zimbabwe'
    when 71
      # Израиль
      file_names = 'israel'
      file_lastnames = 'israel'
    when 72
      # Индия
      file_names = 'indian'
      file_lastnames = 'indian'
    when 73
      # Индонезия
      file_names = 'indonesian'
      file_lastnames = 'indonesian'
    when 76
      # Иран
      file_names = 'iranian'
      file_lastnames = 'iranian'
    when 77, 247
      # Ирландия, Северная Ирландия
      file_names = 'irish'
      file_lastnames = 'irish'
    when 78
      # Исландия
      file_names = 'icelandic'
      file_lastnames = 'icelandic'
    when 80
      # Италия
      file_names = 'italian'
      file_lastnames = 'italian'
    when 83
      # Казахстан
      file_names = 'kazakhstan'
      file_lastnames = 'kazakhstan'
    when 84
      # Камбоджа
      file_names = 'cambodia'
      file_lastnames = 'cambodia'
    when 85
      # Камерун
      file_names = 'cameroon'
      file_lastnames = 'cameroon'
    when 86
      # Канада
      word = rand(150) < 124 ? 'english' : 'french'
      file_names = word
      file_lastnames = word
    when 88
      # Кения
      file_names = 'kenian'
      file_lastnames = 'kenian'
    when 90
      # Кирибати
      file_names = 'kiribati'
      file_lastnames = 'kiribati'
    when 93
      # Коморы
      file_names = 'comorros'
      file_lastnames = 'comorros'
    when 94, 95
      # Конго, Конго, демократическая республика
      file_names = 'congo'
      file_lastnames = 'congo'
    when 96
      # Коста-Рика
      # file_names = 'costa_rica'
      # file_lastnames = 'costa_rica'
    when 97
      # Кот д`Ивуар
      file_names = 'cotedivoire'
      file_lastnames = 'cotedivoire'
    when 98
      # Куба
      # file_names = 'cubinian'
      # file_lastnames = 'cubinian'
    when 100
      # Кыргызстан
      file_names = 'kyrgyz'
      file_lastnames = 'kyrgyz'
    when 102
      # Лаос
      # file_names = 'laos'
      # file_lastnames = 'laos'
    when 103
      # Латвия
      file_names = 'latvian'
      file_lastnames = 'latvian'
    when 104
      # Лесото
      file_names = 'lesotho'
      file_lastnames = 'lesotho'
    when 105
      # Либерия
      file_names = 'liberian'
      file_lastnames = 'liberian'
    when 107
      # Ливия
      file_names = 'libyan'
      file_lastnames = 'libyan'
    when 108
      # Литва
      file_names = 'lithuanian'
      file_lastnames = 'lithuanian'
    when 110
      # Люксембург
      word = rand(100) < 12 ? 'german' : 'french'
      file_names = 'lithuanian'
      file_lastnames = 'lithuanian'
    when 111
      # Маврикий
      file_names = 'mauritius'
      file_lastnames = 'mauritius'
    when 112
      # Мавритания
      file_names = 'mauritanian'
      file_lastnames = 'mauritanian'
    when 113
      # Мадагаскар
      file_names = 'madagascar'
      file_lastnames = 'madagascar'
    when 115
      # Македония
      file_names = 'macedonian'
      file_lastnames = 'macedonian'
    when 116
      # Малави
      file_names = 'malawi'
      file_lastnames = 'malawi'
    when 117
      # Малайзия
      file_names = 'malaysian'
      file_lastnames = 'malaysian'
    when 118
      # Мали
      file_names = 'mali'
      file_lastnames = 'mali'
    when 119
      # Мальдивы
      # file_names = 'maldives'
      # file_lastnames = 'maldives'
    when 120
      # Мальта
      file_names = 'maltese'
      file_lastnames = 'maltese'
    when 123
      # Маршалловы Острова
      # file_names = 'marshalles'
      # file_lastnames = 'marshalles'
    when 125
      # Микронезия, федеративные штаты
      # file_names = 'micronesian'
      # file_lastnames = 'micronesian'
    when 126
      # Мозамбик
      file_names = 'mozambique'
      file_lastnames = 'mozambique'
    when 127
      # Молдова
      file_names = 'moldavian_and_romanian'
      file_lastnames = 'moldavian'
    when 129
      # Монголия
      file_names = 'mongolian'
      file_lastnames = 'mongolian'
    when 131
      # Мьянма
      file_names = 'myanmar'
      file_lastnames = 'myanmar'
    when 132
      # Намибия
      file_names = 'namibian'
      file_lastnames = 'namibian'
    when 133
      # Науру
      # file_names = 'nauru'
      # file_lastnames = 'nauru'
    when 134
      # Непал
      file_names = 'nepalese'
      file_lastnames = 'nepalese'
    when 135
      # Нигер
      file_names = 'niger'
      file_lastnames = 'niger'
    when 136
      # Нигерия
      file_names = 'nigerian'
      file_lastnames = 'nigerian'
    when 138
      # Никарагуа
      # file_names = 'nicaragua'
      # file_lastnames = 'Никарагуа'
    when 139, 140
      # Ниуэ, Новая Зеландия
      file_names = 'maori'
      file_lastnames = 'maori'
    when 142
      # Норвегия
      file_names = 'norway'
      file_lastnames = 'norway'
    when 148
      # Острова Кука
      file_names = 'maori'
      file_lastnames = 'cook_islands'
    when 150
      # Пакистан
      file_names = 'pakistan'
      file_lastnames = 'pakistan'
    when 164
      # Румыния
      file_names = 'moldavian_and_romanian'
      file_lastnames = 'romanian'
    else

    end

    file_names += '_names.yml'
    file_lastnames += '_lastnames.yml'
    [file_names, file_lastnames]
  end
end

# 151 Палау
# 152 Палестинская автономия
# 153 Панама
# 154 Папуа - Новая Гвинея
# 155 Парагвай
# 156 Перу
# 157 Питкерн
# 158 Польша
# 159 Португалия
# 160 Пуэрто-Рико
# 161 Реюньон
# 162 Россия
# 163 Руанда
# 166 Сальвадор
# 167 Самоа
# 168 Сан-Марино
# 169 Сан-Томе и Принсипи
# 170 Саудовская Аравия
# 171 Свазиленд
# 172 Святая Елена
# 173 Северная Корея
# 174 Северные Марианские острова
# 175 Сейшелы
# 176 Сенегал
# 177 Сент-Винсент
# 178 Сент-Китс и Невис
# 179 Сент-Люсия
# 180 Сент-Пьер и Микелон
# 181 Сербия
# 182 Сингапур
# 183 Синт-Мартен
# 184 Сирийская Арабская Республика
# 185 Словакия
# 186 Словения
# 187 Соломоновы Острова
# 188 Сомали
# 189 Судан
# 190 Суринам
# 191 Сьерра-Леоне
# 192 Таджикистан
# 193 Таиланд
# 194 Тайвань
# 195 Танзания
# 196 Того
# 197 Токелау
# 198 Тонга
# 199 Тринидад и Тобаго
# 200 Тувалу
# 201 Тунис
# 202 Туркменистан
# 203 Турция
# 204 Уганда
# 205 Узбекистан
# 206 Украина
# 207 Уоллис и Футуна
# 208 Уругвай
# 209 Фарерские острова
# 210 Фиджи
# 211 Филиппины
# 212 Финляндия
# 213 Фолклендские острова
# 214 Франция
# 215 Французская Гвиана
# 216 Французская Полинезия
# 217 Хорватия
# 218 Центрально-Африканская Республика
# 219 Чад
# 220 Черногория
# 221 Чехия
# 222 Чили
# 223 Швейцария
# 224 Швеция
# 225 Шпицберген и Ян Майен
# 226 Шри-Ланка
# 227 Эквадор
# 228 Экваториальная Гвинея
# 229 Эритрея
# 230 Эстония
# 231 Эфиопия
# 232 Южная Корея
# 233 Южно-Африканская Республика
# 234 Южный Судан
# 235 Ямайка
# 236 Япония
# 237 Абхазия
# 238 Аланд
# 239 Англия
# 240 Канарские острова
# 241 Кокосовые острова (Килинг)
# 242 Майотта
# 243 Нидерландские Антиллы
# 244 Остров Рождества
# 245 Уэльс
# 246 Сен-Бартельми
# 249 Сомалиленд
# 250 Шотландия
# 251 Южная Осетия
# 252 Южная Георгия и Южные Сандвичевы Острова