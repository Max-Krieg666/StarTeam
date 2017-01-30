module Generator
  class RandomName
    attr_accessor :country_id

    def initialize(country_id)
      @country_id = country_id
    end

    def rand_name
      files = define_file
      file1 = YAML.load_file(Rails.root.join('lib', 'names', files[0]))
      file2 = YAML.load_file(Rails.root.join('lib', 'lastnames', files[1]))
      name = file1[SecureRandom.random_number(file1.size)]['name'] + ' ' + file2[SecureRandom.random_number(file2.size)]['lastname']
      name
    end

    def define_file
      file_names = nil
      file_lastnames = nil
      case @country_id
      when 1, 7, 10, 15, 17, 20, 23, 36, 39, 45, 57, 65, 125, 130, 145, 146, 147, 149, 157, 172, 177, 178, 179, 199, 235, 239, 241, 244, 252
        # Австралия, Ангилья, Антигуа и Барбуда, Багамы, Барбадос, Белиз, Бермуды, Великобритания, Виргинские острова, Гайана, Гренада, Доминика, Микронезия, федеративные штаты, Монтсеррат, Остров Мэн, Остров Норфолк, Острова Кайман, Острова Теркс и Кайкос, Питкерн, Остров Святой Елены, Сент-Винсент и Гренадины, Сент-Китс и Невис, Сент-Люсия, Тринидад и Тобаго, Ямайка, Англия, Кокосовые острова (Килинг), Остров Рождества, Южная Георгия и Южные Сандвичевы Острова
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
      when 6, 165, 40, 61, 174
        # Американское Самоа, США, Британские, Виргинские острова, США, Гуам, Северные Марианские острова
        file_names = 'american'
        file_lastnames = 'english'
      when 8, 29, 41, 51, 82, 159, 169
        # Ангола, Бразилия, Восточный Тимор, Гвинея-Бисау, Кабо-Верде, Португалия, Сан-Томе и Принсипи
        file_names = 'portuguese'
        file_lastnames = 'portuguese'
      when 9, 11, 38, 49, 54, 55, 66, 79, 92, 96, 98, 124, 138, 153, 155, 156, 166, 208, 222, 227, 240
        # Андорра, Аргентина, Венесуэла, Гватемала, Гибралтар, Гондурас, Доминиканская Республика, Испания, Колумбия, Коста-Рика, Куба, Мексика, Никарагуа, Панама, Парагвай, Перу, Сальвадор, Уругвай, Чили, Эквадор, Канарские острова
        word =  if @country_id == 79
                  chance = rand(500)
                  if chance > 415
                    'spain_basque'
                  elsif chance < 86
                    'spain_catalonian'
                  else
                    'spain'
                  end
                else
                  'spain'
                end
        file_names = word
        file_lastnames = word
      when 12
        # Армения
        file_names = 'armenian'
        file_lastnames = 'armenian'
      when 13, 26, 101, 137, 183, 190, 243
        # Аруба, Бонайре, Синт-Эстатиус и Саба, Кюрасао, Нидерланды, Синт-Мартен, Суринам, Нидерландские Антиллы
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
      when 18, 74, 75, 81, 87, 99, 106, 143, 144, 152, 170, 184
        # Бахрейн, Иордания, Ирак, Йемен, Катар, Кувейт, Ливан, Объединенные Арабские Эмираты, Оман, Палестинская автономия, Саудовская Аравия, Сирийская Арабская Республика
        file_names = 'arabic'
        file_lastnames = 'arabic'
      when 19
        # Беларусь
        file_names = 'russian_and_belarus'
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
        # Боливия
        chance = rand(500)
        word = chance > 350 ? 'bolivian' : 'spain'
        file_names = word
        file_lastnames = word
      when 27
        # Босния и Герцеговина
        file_names = 'bosnian'
        file_lastnames = 'bosnian'
      when 28
        # Ботсвана
        file_names = 'botswana'
        file_lastnames = 'botswana'
      when 30, 73, 117, 182
        # Бруней-Даруссалам, Индонезия, Малайзия, Сингапур
        file_names = 'malay'
        file_lastnames = 'malay'
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
        file_names = 'bhutan'
        file_lastnames = 'bhutan'
      when 34
        # Вануату
        file_names = 'polinesian'
        file_lastnames = 'vanuatu'
      when 37
        # Венгрия
        file_names = 'hungarian'
        file_lastnames = 'hungarian'
      when 42
        # Вьетнам
        file_names = 'vietnamese'
        file_lastnames = 'vietnamese'
      when 43
        # Габон
        file_names = 'gabon'
        file_lastnames = 'gabon'
      when 46
        # Гамбия
        file_names = 'gambian'
        file_lastnames = 'gambian'
      when 47
        # Гана
        file_names = 'ghana'
        file_lastnames = 'ghana'
      when 44, 48, 122, 128, 141, 161, 180, 207, 214, 215, 216, 242, 246
        # Гаити, Гваделупа, Мартиника, Монако, Новая Каледония, Реюньон, Сент-Пьер и Микелон, Уоллис и Футуна, Франция, Французская Гвиана, Французская Полинезия, Майотта, Сен-Бартельми
        file_names = 'french'
        file_lastnames = 'french'
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
      when 56, 91, 114, 194
        # Гонконг, Китай, Макао, Тайвань
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
      when 35, 80, 168
        # Ватикан, Италия, Сан-Марино
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
      when 97
        # Кот д`Ивуар
        file_names = 'cotedivoire'
        file_lastnames = 'cotedivoire'
      when 100
        # Кыргызстан
        file_names = 'kyrgyz'
        file_lastnames = 'kyrgyz'
      when 102
        # Лаос
        file_names = 'laos'
        file_lastnames = 'laos'
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
        file_names = word
        file_lastnames = word
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
      when 118
        # Мали
        file_names = 'western_african'
        file_lastnames = 'malian'
      when 119
        # Мальдивы
        file_names = 'maldives'
        file_lastnames = 'maldives'
      when 120
        # Мальта
        file_names = 'maltese'
        file_lastnames = 'maltese'
      when 123
        # Маршалловы Острова
        file_names = 'english'
        file_lastnames = 'marshalles'
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
        file_names = 'english'
        file_lastnames = 'nauru'
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
      when 139, 140, 197
        # Ниуэ, Новая Зеландия, Токелау
        file_names = 'maori'
        file_lastnames = 'maori'
      when 142, 225
        # Норвегия, Шпицберген и Ян Майен
        file_names = 'norwegian'
        file_lastnames = 'norwegian'
      when 148
        # Острова Кука
        file_names = 'maori'
        file_lastnames = 'cook_islands'
      when 150
        # Пакистан
        file_names = 'pakistan'
        file_lastnames = 'pakistan'
      when 151
        # Палау
        file_names = 'english'
        file_lastnames = 'palau'
      when 154
        # Папуа - Новая Гвинея
        file_names = 'papua_new_guinea'
        file_lastnames = 'papua_new_guinea'
      when 158
        # Польша
        file_names = 'polish'
        file_lastnames = 'polish'
      when 160, 175
        # Пуэрто-Рико, Сейшелы
        word = rand(100) > 45 ? 'english' : 'french'
        file_names = word
        file_lastnames = word
      when 162
        # Россия
        file_names = 'russian_and_belarus'
        file_lastnames = 'russian'
      when 163
        # Руанда
        file_names = 'rwanda'
        file_lastnames = 'rwanda'
      when 164
        # Румыния
        file_names = 'moldavian_and_romanian'
        file_lastnames = 'romanian'
      when 167
        # Самоа
        file_names = 'samoan'
        file_lastnames = 'samoan'
      when 171
        # Свазиленд
        file_names = rand(44) > 27 ? 'swaziland' : 'south_african'
        file_lastnames = 'swaziland'
      when 173, 232
        # Северная Корея, Южная Корея
        file_names = 'korean'
        file_lastnames = 'korean'
      when 176
        # Сенегал
        file_names = 'senegal'
        file_lastnames = 'senegal'
      when 181, 220
        # Сербия, Черногория
        file_names = 'serbian'
        file_lastnames = 'serbian'
      when 185
        # Словакия
        file_names = 'slovak'
        file_lastnames = 'slovak'
      when 186
        # Словения
        file_names = 'slovenian'
        file_lastnames = 'slovenian'
      when 187
        # Соломоновы Острова
        file_names = 'solomon_islands'
        file_lastnames = 'solomon_islands'
      when 188, 249
        # Сомали, Сомалиленд
        file_names = 'somali'
        file_lastnames = 'somali'
      when 189, 234
        # Судан, Южный Судан
        file_names = 'sudan'
        file_lastnames = 'sudan'
      when 191
        # Сьерра-Леоне
        file_names = 'sierra_leone'
        file_lastnames = 'sierra_leone'
      when 192
        # Таджикистан
        file_names = 'tajik'
        file_lastnames = 'tajik'
      when 193
        # Таиланд
        file_names = 'thai'
        file_lastnames = 'thai'
      when 195
        # Танзания
        file_names = 'tanzanian'
        file_lastnames = 'tanzanian'
      when 196
        # Того
        file_names = 'togo'
        file_lastnames = 'togo'
      when 198
        # Тонга
        file_names = 'tonga'
        file_lastnames = 'tonga'
      when 200
        # Тувалу
        file_names = 'polinesian'
        file_lastnames = 'tuvaluan'
      when 201
        # Тунис
        file_names = 'tunisian'
        file_lastnames = 'tunisian'
      when 202
        # Туркменистан
        file_names = 'turkmenian'
        file_lastnames = 'turkmenian'
      when 203
        # Турция
        file_names = 'turkey'
        file_lastnames = 'turkey'
      when 204
        # Уганда
        file_names = 'uganda'
        file_lastnames = 'uganda'
      when 205
        # Узбекистан
        file_names = 'uzbek'
        file_lastnames = 'uzbek'
      when 206
        # Украина
        file_names = 'ukrainian'
        file_lastnames = 'ukrainian'
      when 209
        # Фарерские острова
        file_names = 'faroe'
        file_lastnames = 'faroe'
      when 210
        # Фиджи
        file_names = 'fiji'
        file_lastnames = 'fiji'
      when 211
        # Филиппины
        file_names = 'philippinian'
        file_lastnames = 'philippinian'
      when 212, 238
        # Финляндия, Аланд
        file_names = 'finnish'
        file_lastnames = 'finnish'
      when 213
        # Фолклендские острова
        word = rand(100) > 66 ? 'spain' : 'english'
        file_names = word
        file_lastnames = word
      when 217
        # Хорватия
        file_names = 'croatian'
        file_lastnames = 'croatian'
      when 218
        # Центрально-Африканская Республика
        file_names = 'car'
        file_lastnames = 'car'
      when 219
        # Чад
        file_names = 'chad'
        file_lastnames = 'chad'
      when 221
        # Чехия
        file_names = 'czech'
        file_lastnames = 'czech'
      when 223
        # Швейцария
        file_names = 'swiss'
        file_lastnames = 'swiss'
      when 224
        # Швеция
        file_names = 'swedish'
        file_lastnames = 'swedish'
      when 226
        # Шри-Ланка
        file_names = 'sri_lankan'
        file_lastnames = 'sri_lankan'
      when 228
        # Экваториальная Гвинея
        file_names = 'equatorial_guinea'
        file_lastnames = 'equatorial_guinea'
      when 229
        # Эритрея
        file_names = 'eastern_african'
        file_lastnames = 'eritrean'
      when 230
        # Эстония
        file_names = 'estonian'
        file_lastnames = 'estonian'
      when 231
        # Эфиопия
        file_names = 'ethiopian'
        file_lastnames = 'ethiopian'
      when 233
        # Южно-Африканская Республика
        file_names = 'sar'
        file_lastnames = 'sar'
      when 236
        # Япония
        file_names = 'japanese'
        file_lastnames = 'japanese'
      when 237, 251
        # Абхазия, Южная Осетия
        file_names = 'abkhazian'
        file_lastnames = 'abkhazian'
      when 245
        # Уэльс
        file_names = 'welsh'
        file_lastnames = 'welsh'
      when 250
        # Шотландия
        file_names = 'scotland'
        file_lastnames = 'scotland'
      end
      raise "имён для страны #{@country_id} нету!" unless file_names.present?
      file_names += '_names.yml'
      file_lastnames += '_lastnames.yml'
      [file_names, file_lastnames]
    end
  end
end
