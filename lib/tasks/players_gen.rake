require File.expand_path(File.dirname(__FILE__) + "/bd1.rb")
require File.expand_path(File.dirname(__FILE__) + "/bd2.rb")
require File.expand_path(File.dirname(__FILE__) + "/bd3.rb")
DEF=2

desc "Создание #{DEF} игроков"
namespace :players do
  task :create=>:environment do
    DEF.times do
      x,bar=rand(90)+1,""
      pl=Player.new
      pl.position1=@pos[rand(@pos.size)]
      pl.position2=""
      tal=rand(700)+1
      k=(case tal
      when 0..88
        1
      when 89..168
        2
      when 169..258
        3
      when 259..347
        4
      when 348..479
        5
      when 480..545
        6
      when 546..611
        7
      when 612..666
        8
      else
        9
      end)
      pl.talent=k
      z=rand(1000)+1
      age=(case z
      when 0..88
        k>=7 ? 25 : (k<3 ? 31 : 29)
      when 89..168
        k>=7 ? 24 : (k<3 ? 30 : 28)
      when 169..258
        k>=7 ? 23 : (k<3 ? 27 : 36)
      when 259..347
        k>=7 ? 22 : (k<3 ? 35 : 33)
      when 348..479
        k>=7 ? 21 : (k<3 ? 34 : 38)
      when 480..545
        k>=7 ? 20 : (k<3 ? 37 : 32)
      when 546..611
        k>=7 ? 19 : (k<3 ? 26 : 22)
      when 612..666
        k>=7 ? 18 : (k<3 ? 31 : 20)
      when 667..800
        k>=7 ? 28 : (k<3 ? 33 : 35)
      when 801..877
        k>=7 ? 26 : (k<3 ? 30 : 23)
      when 878..950
        k>=7 ? 27 : (k<3 ? 29 : 30)
      else
        k>=7 ? 17 : (k<3 ? 27 : 18)
      end)
      pl.age=age
      lvl=rand(400)+1
      l=(case lvl
      when 0..88
        k>5 ? rand(45..63) : rand(25..44)
      when 89..168
        k>5 ? rand(40..60) : rand(29..39)
      when 169..258
        rand(40..74)
      when 259..347
        k>5 ? rand(50..57) : rand(37..49)
      when 348..350
        rand(70..125)
      else
        rand(25..74)
      end)
      pl.skill_level=l
      pl.price=pl.talent*pl.skill_level*10000/pl.age
      case x
      when 1,5,10,12,23 #Россия
        name=@rus_names[rand(@rus_names.size)]
        lastname=@rus_lastnames[rand(@rus_lastnames.size)]
        pl.country_id=160
      when 2,13,24 #Англия
        name=@eng_names[rand(@eng_names.size)]
        lastname=@eng_lastnames[rand(@eng_lastnames.size)]
        pl.country_id=237
      when 3,25 #Ирландия
        name=@irl_names[rand(@irl_names.size)]
        lastname=@irl_lastnames[rand(@irl_lastnames.size)]
        pl.country_id=75
      when 4,26 #Шотландия
        name=@sct_names[rand(@sct_names.size)]
        lastname=@sct_lastnames[rand(@sct_lastnames.size)]
        pl.country_id=250
      when 27,33 #Болгария
        name=@blg_names[rand(@blg_names.size)]
        lastname=@blg_lastnames[rand(@blg_lastnames.size)]
        pl.country_id=24
      when 6,28 #Венгрия
        name=@hng_names[rand(@hng_names.size)]
        lastname=@hng_lastnames[rand(@hng_lastnames.size)]
        pl.country_id=37
      when 7,29 #Дания
        name=@den_names[rand(@den_names.size)]
        lastname=@den_lastnames[rand(@den_lastnames.size)]
        pl.country_id=61
      when 8,11,31 #Исландия
        name=@isl_names[rand(@isl_names.size)]
        bar=@isl_names[rand(@isl_names.size)]+" " if rand(50)>15
        lastname=@isl_lastnames[rand(@isl_lastnames.size)]
        pl.country_id=76
      when 9,14,30 #Испания
        name=@spa_names[rand(@spa_names.size)]
        lastname=@spa_lastnames[rand(@spa_lastnames.size)]
        pl.country_id=77
      when 15,16,32 #Италия
        name=@ita_names[rand(@ita_names.size)]
        lastname=@ita_lastnames[rand(@ita_lastnames.size)]
        pl.country_id=78
      when 17,34,40 #Германия
        name=@ger_names[rand(@ger_names.size)]
        lastname=@ger_lastnames[rand(@ger_lastnames.size)]
        pl.country_id=52
      when 18,19,39 #Нидерланды
        name=@dut_names[rand(@dut_names.size)]
        lastname=@dut_lastnames[rand(@dut_lastnames.size)]
        pl.country_id=135
      when 20,35,41 #Норвегия
        name=@nor_names[rand(@nor_names.size)]
        lastname=@nor_lastnames[rand(@nor_lastnames.size)]
        pl.country_id=140
      when 21,36 #Польша
        name=@pol_names[rand(@pol_names.size)]
        lastname=@pol_lastnames[rand(@pol_lastnames.size)]
        pl.country_id=156
      when 22,37,44 #Португалия
        name=@por_names[rand(@por_names.size)]
        lastname=@por_lastnames[rand(@por_lastnames.size)]
        pl.country_id=157
      when 38,42,47 #Бразилия
        name=@bra_names[rand(@bra_names.size)]
        lastname=@bra_lastnames[rand(@bra_lastnames.size)]
        pl.country_id=29
      when 43,45 #Румыния или Молдова
        name=@rom_names[rand(@rom_names.size)]
        lastname=@rom_lastnames[rand(@rom_lastnames.size)]
        pl.country_id=(rand(86)>=rand(100) ? 162:125)
      when 46,48 #Финляндия
        name=@fin_names[rand(@fin_names.size)]
        lastname=@fin_lastnames[rand(@fin_lastnames.size)]
        pl.country_id=210
      when 49,51,53 #Франция
        name=@fra_names[rand(@fra_names.size)]
        lastname=@fra_lastnames[rand(@fra_lastnames.size)]
        pl.country_id=212
      when 50,54 #Чехия
        name=@cze_names[rand(@cze_names.size)]
        lastname=@cze_lastnames[rand(@cze_lastnames.size)]
        pl.country_id=219
      when 52,55 #Швеция
        name=@swe_names[rand(@swe_names.size)]
        lastname=@swe_lastnames[rand(@swe_lastnames.size)]
        pl.country_id=222
      when 56,58 #Сербия и Черногория
        name=@srb_names[rand(@srb_names.size)]
        lastname=@srb_lastnames[rand(@srb_lastnames.size)]
        pl.country_id=(rand(95)>=rand(100) ? 179:218)
      when 57,59 #Израиль
        name=@isr_names[rand(@isr_names.size)]
        lastname=@isr_lastnames[rand(@isr_lastnames.size)]
        pl.country_id=69
      when 61 #Абхазия
        name=@abh_names[rand(@abh_names.size)]
        lastname=@abh_lastnames[rand(@abh_lastnames.size)]
        pl.country_id=235
      when 60,63 #Украина
        name=@ukr_names[rand(@ukr_names.size)]
        lastname=@ukr_lastnames[rand(@ukr_lastnames.size)]
        pl.country_id=204
      when 64 #Грузия
        name=@geo_names[rand(@geo_names.size)]
        lastname=@geo_lastnames[rand(@geo_lastnames.size)]
        pl.country_id=59
      when 66 #Армения
        name=@arm_names[rand(@arm_names.size)]
        lastname=@arm_lastnames[rand(@arm_lastnames.size)]
        pl.country_id=12
      when 62,67 #Бельгия
        if rand(25)>=rand(50)
          name=@fra_names[rand(@fra_names.size)]
          lastname=@fra_lastnames[rand(@fra_lastnames.size)]
          pl.country_id=212
        else
          name=@dut_names[rand(@dut_names.size)]
          lastname=@dut_lastnames[rand(@dut_lastnames.size)]
          pl.country_id=135
        end
      when 69 #Индонезия
        name=@indn_names[rand(@indn_names.size)]
        lastname=@indn_lastnames[rand(@indn_lastnames.size)]
        pl.country_id=71
      when 65,70 #Иран
        name=@iran_names[rand(@iran_names.size)]
        lastname=@iran_lastnames[rand(@iran_lastnames.size)]
        pl.country_id=74
      when 71 #Алжир
        name=@mus_names[rand(@mus_names.size)]
        lastname=@alg_lastnames[rand(@alg_lastnames.size)]
        pl.country_id=5
      else #68,72..90 -- Мусульманские страны
        name=@mus_names[rand(@mus_names.size)]
        if rand(70)>=rand(40)
          #ar1:Бахрейн,Ирак,Кувейт,Оман,Катар,Саудовская Аравия и ОАЭ
          bar=@ar1_prephixes[rand(@ar1_prephixes.size)]
          lastname=@ar1_lastnames[rand(@ar1_lastnames.size)]
          mas=[18,73,97,142,85,168,141]
          pl.country_id=mas[rand(mas.size)]
        else
          #ar2:Иордания,Ливан,Палестина,Сирия
          bar=@ar2_prephixes[rand(@ar2_prephixes.size)]
          lastname=@ar2_lastnames[rand(@ar2_lastnames.size)]
          mas=[72,104,150,182]
          pl.country_id=mas[rand(mas.size)]
        end
      end
      pl.name=name+" "+bar+lastname
      pl.save!
    end
  end
end