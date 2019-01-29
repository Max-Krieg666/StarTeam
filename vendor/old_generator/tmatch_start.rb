#!/usr/bin/env ruby
# encoding:UTF-8
# Author: Max Bogoyavlenskiy (c) 2012-2013
# For Project "VFMIL" Virtual Football Manager "Soccer In Life" (c) (r)
# Собственно здесь и моделируется события и счёт матча
require "./processing"
require "./teams_fulled"
EPS=1.0e-10
team1="Bullet_for_my_Valentine" #gets.chomp
team2="Рауль" #gets.chomp
@home=0 # team1 - хозяева
@guest=0 # team2 - гости
if team1=="Fram_Reykjavik"
  @sost1=(@@fram.status)[0].flatten
  @team_element1=@@fram
elsif team1=="oleg_Dm"
  @sost1=(@@odm.status)[0].flatten
  @team_element1=@@odm
elsif team1=="VeneziaFC"
  @sost1=(@@vfc.status)[0].flatten
  @team_element1=@@vfc
elsif team1=="Bullet_for_my_Valentine"
  @sost1=(@@bfmv.status)[0].flatten
  @team_element1=@@bfmv
elsif team1=="Spartak_United"
  @sost1=(@@spartak_un.status)[0].flatten
  @team_element1=@@spartak_un
elsif team1=="idelgumer"
  @sost1=(@@idelgumer.status)[0].flatten
  @team_element1=@@idelgumer
elsif team1=="DroN"
  @sost1=(@@dron.status)[0].flatten
  @team_element1=@@dron
elsif team1=="Рауль"
  @sost1=(@@raul.status)[0].flatten
  @team_element1=@@raul
elsif team1=="Ачача"
  @sost1=(@@achacha.status)[0].flatten
  @team_element1=@@achacha
elsif team1=="SpartaK"
  @sost1=(@@spartak.status)[0].flatten
  @team_element1=@@spartak
elsif team1=="XSeme4KaX"
  @sost1=(@@xseme4kax.status)[0].flatten
  @team_element1=@@xseme4kax
elsif team1=="rilin"
  @sost1=(@@rilin.status)[0].flatten
  @team_element1=@@rilin
elsif team1=="AnFair"
  @sost1=(@@anfair.status)[0].flatten
  @team_element1=@@anfair
elsif team1=="Анархист"
  @sost1=(@@anarchist.status)[0].flatten
  @team_element1=@@anarchist
end
if team2=="Fram_Reykjavik"
  @sost2=(@@fram.status)[0].flatten
  @team_element2=@@fram
elsif team2=="oleg_Dm"
  @sost2=(@@odm.status)[0].flatten
  @team_element2=@@odm
elsif team2=="VeneziaFC"
  @sost2=(@@vfc.status)[0].flatten
  @team_element2=@@vfc
elsif team2=="Bullet_for_my_Valentine"
  @sost2=(@@bfmv.status)[0].flatten
  @team_element2=@@bfmv
elsif team2=="Spartak_United"
  @sost2=(@@spartak_un.status)[0].flatten
  @team_element2=@@spartak_un
elsif team2=="idelgumer"
  @sost2=(@@idelgumer.status)[0].flatten
  @team_element2=@@idelgumer
elsif team2=="DroN"
  @sost2=(@@dron.status)[0].flatten
  @team_element2=@@dron
elsif team2=="Рауль"
  @sost2=(@@raul.status)[0].flatten
  @team_element2=@@raul
elsif team2=="Ачача"
  @sost2=(@@achacha.status)[0].flatten
  @team_element2=@@achacha
elsif team2=="SpartaK"
  @sost2=(@@spartak.status)[0].flatten
  @team_element2=@@spartak
elsif team2=="XSeme4KaX"
  @sost2=(@@xseme4kax.status)[0].flatten
  @team_element2=@@xseme4kax
elsif team2=="rilin"
  @sost2=(@@rilin.status)[0].flatten
  @team_element2=@@rilin
elsif team2=="AnFair"
  @sost2=(@@anfair.status)[0].flatten
  @team_element2=@@anfair
elsif team2=="Анархист"
  @sost2=(@@anarchist.status)[0].flatten
  @team_element2=@@anarchist
end
def match_act(team1,team2)
  result=@team_element1.power.to_f/@team_element2.power.to_f
  if result>=4.0 # Определение той команды, которая будет атаковать, в зависимости от ее силы и силы соперника
    var=rand(10)+1
    var==3 ? gir=1 : gir=0
  elsif result>=2.0 && result<4.0
    var=rand(10)+1
    var>=1 && var<=7 ? gir=0 : gir=1
  elsif result>=1.3 && result<2.0
    var=rand(10)+1
    var>=1 && var<=6 ? gir=0 : gir=1
  elsif result>=0.7 && result<1.3
    var=rand(10)+1
    var>=1 && var<=5 ? gir=0 : gir=1
  elsif result>=0.5 && result<0.7
    var=rand(10)+1
    var>=1 && var<=4 ? gir=0 : gir=1
  elsif result>=0.25 && result<0.5
    var=rand(10)+1
    var>=1 && var<=3 ? gir=0 : gir=1
  elsif result<0.25
    var=rand(10)+1
    var==8 ? gir=0 : gir=1
  end
  if gir==0
    @team_attack,@team_defend,@nam_attack,@nam_defend=@sost1,@sost2,team1,team2
  else
    @team_attack,@team_defend,@nam_attack,@nam_defend=@sost2,@sost1,team2,team1
  end
  if @team_attack[0].position.include?("Gk") && @team_defend[0].position.include?("Gk")
    @keeper_attack,@keeper_defend=@team_attack[0],@team_defend[0]
    @team_attack.delete(@team_attack[0]); @team_defend.delete(@team_defend[0])
  end

  num1,num2=@team_attack.size,@team_defend.size
  pl1,pl2=rand(num1),rand(num2)
  j=rand(5); act=rand(10000) # Ценность момента



  ##############тут остановился (GameEngine / EventEngine / GameEvent)
  if act>0 && act<=4300
    x=0; return # Ничего не произошло
  elsif (act>4300) && (act<=6400)
    danger=1 # Пас или другое развитие атаки
    var_moments=["#{@team_attack[pl1].name} из команды #{@nam_attack} начинает атаку длинным забросом на чужую половину поля.", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается прорваться по флангу и делает сильную передачу вперед!", "#{@team_attack[pl1].name} из команды #{@nam_attack} выносит мяч далеко вперед!", "Игрок #{@team_attack[pl1].name} из команды #{@nam_attack} делает пас на партнера.", "#{@team_attack[pl1].name} из команды #{@nam_attack} демонстрирует прекрасный дриблинг в центре поля."]
  elsif (act>6400) && (act<=7950)
    danger=2 # Пас или другое развитие атаки
    var_moments=["#{@team_attack[pl1].name} из команды #{@nam_attack} обводит соперника в центре поля.", "#{@team_attack[pl1].name} из команды #{@nam_attack} несется с мячом через всё поле! Никто не может его остановить!", "#{@team_attack[pl1].name} из команды #{@nam_attack} делает длинный заброс вперед.", "Пас вразрез делает #{@team_attack[pl1].name} из команды #{@nam_attack}. Партнер успешно принимает мяч!", "#{@team_attack[pl1].name} из команды #{@nam_attack} со всей силы выносит мяч подальше от своих ворот!"]
  elsif (act>7950) && (act<=9230)
    danger=3 # Аут, угловой, штрафной или перспективная атака
    j=rand(7)
    var_moments=["Аут вбрасывает #{@team_attack[pl1].name} из команды #{@nam_attack}.", "#{@team_attack[pl1].name} из команды #{@nam_attack} на всех парах несется к штрафной соперника! Может получится интересный момент!", "#{@team_attack[pl1].name} из команды #{@nam_attack} одного за другим обводит игроков соперника!", "#{@team_attack[pl1].name} из команды #{@nam_attack} продолжает атаку, начатую вратарем. Он принимает мяч неподалеку от штрафной соперника!", "#{@team_attack[pl1].name} из команды #{@nam_attack} начинает прорыв по флангу! Он демонстрирует отменную технику!", "Угловой зарабатывает команда #{@nam_attack}. #{@team_attack[pl1].name} отправился подавать.", "Штрафной пробьет #{@team_attack[pl1].name} из команды #{@nam_attack}."]
  elsif (act>9230) && (act<=10000)
    danger=4 # Голевая возможность
    j=rand(7)
    var_moments=["Очень опасный момент! #{@team_attack[pl1].name} из команды #{@nam_attack} вкладывает всю силу в удар по воротам!", "#{@team_attack[pl1].name} из команды #{@nam_attack} прицельно бьёт по мячу!", "#{@team_attack[pl1].name} из команды #{@nam_attack} бьёт с лёту!", "#{@team_attack[pl1].name} из команды #{@nam_attack} останавливает мяч и опасно бьёт по воротам!", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается завершить атаку дальним ударом!", "#{@team_attack[pl1].name} из команды #{@nam_attack} пытается прорваться к воротам! Осталось всего двух защитников обыграть!", "#{@team_attack[pl1].name} из команды #{@nam_attack} делает пас вразрез, выводя своего партнера на рандеву с вратарем соперников!"]
  end
  puts var_moments[j]; sleep 1
  if danger==1 && (j==0 || j==1) || danger==2 && j==4
    if @team_attack[pl1].specialskills.include?("Ск") || @team_attack[pl1].level >= 80 || @team_attack[pl1].specialskills.include?("Тх")
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      action_next=["#{@team_attack[pl1].name} прорывается сквозь рубежи обороны противника!", "#{@team_attack[pl1].name} беспрепятственно несется по флангу!"]
      j=rand(2); classification=1.1
    elsif @team_defend[pl2].position.include?("Cd") || @team_defend[pl2].position.include?("Rd") || @team_defend[pl2].position.include?("Ld")
      action_next=["Ему пытается помешать игрок #{@team_defend[pl2].name} из команды #{@nam_defend}.", "#{@team_defend[pl2].name} из команды #{@nam_defend} делает попытку отобрать мяч у соперника!"]
      j=rand(2); classification=1.2
    else
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      action_next=["#{@team_attack[pl1].name} предлагает себя в качестве продолжения!"]
      j=0; classification=1.3
    end
  elsif danger==1 && j==2
    @counting=rand(10)+1
    if @counting==9 || @counting==3
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      action_next=["Мяч чудом получает его партнер по команде #{@team_attack[pl1].name}!"]
      j=0; classification=2
    else
      sleep 1; return
    end
  elsif danger==1 && j==3 || danger==2 && j==2
    pl2=rand(num2)
    if @team_defend[pl2].level > @team_attack[pl1].level || (@team_defend[pl2].position.include?("Cd") || @team_defend[pl2].position.include?("Rd") || @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].position.include?("Cdm")) && (!@team_attack[pl1].position.include?("Rf") || !@team_attack[pl1].position.include?("Cf") || !@team_attack[pl1].position.include?("Lf") || !@team_attack[pl1].position.include?("St")) && !@team_attack[pl1].position.include?("Cam") && @team_defend[pl2].level >= 40 && @team_attack[pl1].level < 61
      action_next=["#{@team_defend[pl2].name} перехватывает мяч и выносит его.", "#{@team_defend[pl2].name} совершает успешный подкат."]
      j=rand(2); puts action_next[j]; sleep 1; return
    elsif @team_defend[pl2].level <= @team_attack[pl1].level && !@team_defend[pl2].specialskills.include?("Пд")
      action_next=["#{@team_defend[pl2].name} совершает очень грубый подкат. За этим нарушением обязательно должна следовать карточка!", "Грязно играет #{@team_defend[pl2].name}. Подкат сзади."]
      j=rand(2); classification=3.2
    else
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      action_next=["#{@team_attack[pl1].name} успешно принимает мяч от партнера и совершает ускорение.", "#{@team_attack[pl1].name} принимает мяч и несется к штрафной!"]
      j=rand(2); classification=3.3
    end
  elsif danger==1 && j==4 || danger==2 && (j==0 || j==1)
    if @team_defend[pl2].level > @team_attack[pl1].level || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Cd") || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Rd")
      action_next=["#{@team_defend[pl2].name} из команды #{@nam_defend} отчаянно бросается в подкат!", "#{@team_defend[pl2].name} из команды #{@nam_defend} пытается отобрать мяч!"]
      j=rand(2); classification=4.1
    else
      action_next=["#{@team_attack[pl1].name} беспрепятственно проходит игроков соперника одного за другим!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
      j=rand(2); classification=4.2
    end
  elsif danger==2 && j==3
    pl1=rand(num1)
    action_next=["#{@team_attack[pl1].name} обработал пас и совершает ускорение.", "#{@team_attack[pl1].name} принимает мяч и несется к штрафной!"]
    j=rand(2); classification=5
  elsif danger==3 && j==0
    pl_old1=pl1
    while pl_old1==pl1
      pl1=rand(num1)
    end
    action_next=["Аут вброшен неточно, мяч потерян.", "#{@team_attack[pl1].name} принял мяч и думает над развитием атаки.", "Мяч удачно вброшен на ход, #{@team_attack[pl1].name} совершает забег с ним."]
    j=rand(3); classification=6
    if j==0
      puts action_next[0]; sleep 1; return
    end
  elsif danger==3 && j==1 || danger==3 && j==4
    if @team_attack[pl1].specialskills.include?("Ск") || @team_attack[pl1].level >= 80 || @team_attack[pl1].specialskills.include?("Тх")
      action_next=["#{@team_attack[pl1].name} беспрепятственно проходит игроков соперника одного за другим!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
      j=rand(2); classification=7.1
    elsif (@team_defend[pl2].position.include?("Cd") || @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].position.include?("Rd")) && @team_defend[pl2].level >= 55
      action_next=["Ему пытается помешать игрок #{@team_defend[pl2].name} из команды #{@nam_defend}.", "#{@team_defend[pl2].name} из команды #{@nam_defend} делает попытку отобрать мяч у соперника!"]
      j=rand(2); classification=7.2
    else
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      action_next=["#{@team_attack[pl1].name} предлагает себя в качестве продолжения!"]
      j=0; classification=7.3
    end
  elsif danger==3 && j==2
    if @team_defend[pl2].level > @team_attack[pl1].level || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("d")
      action_next=["#{@team_defend[pl2].name} из команды #{@nam_defend} отчаянно бросается в подкат!", "#{@team_defend[pl2].name} из команды #{@nam_defend} пытается отобрать мяч!"]
      j=rand(2); classification=8.1
    else
      action_next=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
      j=rand(2); classification=8.2
    end
  elsif danger==3 && j==3
    action_next=["Он готовится нанести удар по воротам! И вот удар!", "Он останавливает мяч и бьёт!", "Сокрушительной силы удар по воротам!", "#{@team_attack[pl1].name} врывается в штрафную!"]
    j=rand(4); classification=9
  elsif danger==3 && j==5
    count=rand(6000)
    pl_old1=pl1
    while pl_old1==pl1
      pl1=rand(num1)
    end
    if count==4889 || count==5123
      action_next="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
      puts action_next; sleep 1
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      pl_at=rand(num1); count=rand(5)
      if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
        action_next=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
        j=rand(3); classification=10
      else
        new_count=rand(3)
        if new_count==1
          action_next=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
          j=rand(3); puts action_next[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
        else
          action_next=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
          j=rand(3); puts action_next[j]; sleep 1; return
        end
      end
    end
  elsif danger==3 && j==6
    if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
      action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
      j=rand(3); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      count=rand(20)
      if count==3 || count==7 || count==8
        action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
        j=rand(3); puts action_next[j]
        @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
        @nam_attack==team1 ? @home+=1 : @guest+=1
        3.times do
          print "ГОЛ! "; sleep 2
        end
        puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
      elsif count==0 || @keeper_defend.level >= 60
        action_next=["Голкипер среагировал на этот мощный удар! Угловой!", "Голкипер переводит мяч на угловой.", "Мяч попадает в стенку и от кого-то из защитников уходит на угловой."]
        j==rand(3); classification=11.1
      elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
        action_next=["Мяч угодил в стенку и им завладели соперники.", "После неочень удачной подачи в борьбу мяч потерян для атакующей команды."]
        j=rand(3); puts action_next[j]; sleep 1; return
      else
        action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
        j==rand(3); classification=11.2
      end
    end
  elsif danger==4 && (j==0 || j==1 || j==2 || j==3)
    if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
      action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
      j=rand(3); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      count=rand(20)
      if count==3 || count==7 || count==8
        action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
        j=rand(3); puts action_next[j]
        @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
        @nam_attack==team1 ? @home+=1 : @guest+=1
        3.times do
          print "ГОЛ! "; sleep 2
        end
        puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
      elsif count==0 || @keeper_defend.level >= 60
        action_next=["Голкипер среагировал на этот мощный удар! Угловой!", "Голкипер переводит мяч на угловой.", "Мяч попадает в стенку и от кого-то из защитников уходит на угловой."]
        j==rand(3); classification=12.1
      elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
        action_next=["Мяч угодил в стенку и им завладели соперники.", "После неочень удачной подачи в борьбу мяч потерян для атакующей команды."]
        j=rand(3); puts action_next[j]; sleep 1; return
      else
        action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
        j==rand(3); classification=12.2
      end
    end
  elsif danger==4 && j==4
    count=rand(10)
    if count==4 || @team_attack[pl1].level>=80 || @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
      action_next=["Удар потрясающий по силе и точности! ГОЛ!", "Вратарь оказался не готов к такому развитию событий. Гол забит!", "Рикошет от защитника и мяч в воротах!", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
      j=rand(4); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    elsif count==6
      action_next=["Мяч ударяется об защитника и летит на угловой.", "#{@keeper_defend.name} обладает отличной реакцией! Перевел мяч на угловой! Выручил свою команду!"]
      j=rand(2); classification=13
    else
      action_next=["Удар получился неочень сильным и вратарь беспрепятственно поймал мяч.", "#{@team_defend[pl2].name} блокирует удар!", "Удар очень неточный. Мяч улетает за лицевую линию.", "#{@team_attack[pl1].name} попадает в каркас ворот! Очень опасный удар! Но мяч для атакующей команды потерян."]
      j=rand(4); puts action_next[j]; sleep 1; return
    end
  elsif danger==4 && j==5
    if count==9 || @team_attack[pl1].level>=80 && @keeper_defend.level < @team_attack[pl1].level || @team_attack[pl1].specialskills.include?("Тх") || @team_attack[pl1].level>=62 && @team_attack[pl1].specialskills.include?("Ск")
      action_next=["Прекрасный дриблинг демонстрирует нам #{@team_attack[pl1].name}! Он прокидывает мяч между двух защитников! Последует удар по воротам!", "Отличная техника. Вот у него бы поучиться владеть мячом! Он бьет из-под защитника!", "Потрясающий финт по сложности и красоте! Он выходит к воротам и намеревается бить!", "Он прицеливается и бьет!"]
      j=rand(4); classification=14.1
    elsif (count==1 || count==4 || count==6 || count==8) && (!@team_defend[pl2].specialskills.include?("Пд") || !@team_attack[pl1].specialskills.include?("Пр")) || @team_defend[pl2].level<=74
      newcount=rand(5)
      srand=rand(8)
      injur1=rand(12)
      if newcount>=3
        action_next=["Один из защитников, а точнее, #{@team_defend[pl2].name}, фолит на нападающем. Впрочем, нарушение не серьёзное, и только штрафной.", "Нападающего сбивают, однако карточки нет. Штрафной удар.", "Подножка от игрока обороны, однако арбитр всего лишь дает штрафной удар в непосредственной близости от ворот.", "Фол рядом с штрафной!!! Будет ли карточка?.. Нет, судья отделался лишь устным предупреждением."]
        j=rand(4); classification=14.2
      elsif srand<=2
        action_next=["Фол последней надежды. #{@team_defend[pl2].name} совершенно справедливо удален с поля. Судья дает пенальти!", "Прямой ногой идет в стык с нападающим #{@team_defend[pl2].name}. Судья бежит к месту событий... Красная карточка и пенальти!", "#{@team_defend[pl2].name} хватает нападающего за футболку, он картинно падает, однако судья купился на эту уловку. И.. удаляет игрока защиты! Обороняющаяся команда в меньшинстве будет! Да еще и пенальти назначается!"]
        j=rand(3); classification=14.3; @team_defend[pl2].redcards(1); @team_defend.delete(@team_defend[pl2])
      else
        action_next=["Грубый подкат сбоку в исполнении защитника. #{@team_defend[pl2].name} получает желтую карточку. Назначен штрафной.", "Штрафной удар назначен в пользу атакующей команды благодаря грубому подкату игрока защиты. За этот подкат #{@team_defend[pl2].name} получает горчичник.", "Последовал подкат, #{@team_attack[pl1].name} корчится на газоне от боли... #{@team_defend[pl2].name} получает желтую. Прав судья, по-моему.", "#{@team_defend[pl2].name} делает подножку сопернику, за что и наказывается желтой карточкой."]
        j=rand(4); classification=14.4; @team_defend[pl2].yellowcards(1); rej=@team_defend[pl2].yel_cards
        if rej==2
          puts "Это вторая желтая карточка для этого игрока. #{@team_defend[pl2].name} пытается безуспешно спорить с арбитром. Его удаляют с поля."
          @team_defend[pl2].redcards(1); @team_defend.delete(@team_defend[pl2]); num2=rand(@team_defend.size)
        end
      end
      if injur1==5 || injur1==6 || injur1==8 || injur1==11
        mat=rand(6)+1
        if mat==1
          sr="у."
        elsif mat==2 || mat==3 || mat==4
          sr="ы."
        else
          sr="."
        end
        action_inj=["#{@team_attack[pl1].name} получает травму и выбывает на #{mat} игр#{sr}", "#{@team_attack[pl1].name} получает досадную травму и выбывает на #{mat} игр#{sr}", "Серьезную травму после столкновения с соперником получает #{@team_attack[pl1].name}. Он выбывает на #{mat} игр#{sr}"]
        ker=rand(3)
        @team_attack[pl1].position.size==1 ? fact=@team_attack[pl1].position[0] : fact=@team_attack[pl1].position[0]
        for i in 0...@team_element1.status[1].size
          for k in 0...@team_element1.status[1][i].size
            if @team_element1.status[1][i][k].position.include?(fact)
              @pl1_new=@team_element1.status[1][i][k]; break
            end
          end
        end
        if @pl1_new.nil?
          @pl1_new=@team_element1.status[1][2][0]
        end
        puts action_next[j]; puts action_inj[ker]; puts "#{@pl1_new.name} >>"; puts "<< #{@team_attack[pl1].name}"
        @team_attack[pl1].injure(mat); @team_attack[pl1]=@pl1_new; @pl1_new.games_plus(1); pl1=rand(num1)
      end
    else
      action_next=["К сожалению для нападающего, дриблинг не удался. Мяч потерян.", "#{@team_defend[pl2].name} отбирает мяч и выносит подальше!", "Защитники остановили нападающего!"]
      j=rand(3); puts action_next[j]; sleep 1; return
    end
  else
    pl_old1=pl1
    while pl_old1==pl1
      pl1=rand(num1)
    end
    gonz=rand(15)
    if gonz<=7 && (@team_attack[pl1].specialskills.include?("Од") || (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Ск")) && @team_attack[pl1].level>64 || @team_attack[pl1].level>@keeper_defend.level)
      action_next=["Следует сближение с вратарем и удар потрясающий по силе и точности! ГОЛ-красавец! Девятка! Автор - #{@team_attack[pl1].name}.", "Вратарь оказался не готов к такому развитию событий. #{@team_attack[pl1].name} перебрасывает мяч через него! ГОЛ!", "Вратарь дотягивается до мяча, однако он все равно оказывается в воротах! #{@team_attack[pl1].name} записан как автор гола.", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
      j=rand(4); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    elsif gonz==8 || gonz==9
      act_next=["Вратарь идет на сближение с нападающим и бросается ему в ноги! Фол последней надежды! Удаление вратаря и пенальти!", "Вратарь фолит на нападающем и удаляется с поля! Справедливый пенальти!"]
      j=rand(2); @keeper_defend.redcards(1)
      @keep_new=@team_element1.status[1][0][0]; pl2=rand(num2)
      zamena="Основной вратарь удален. Тренер выводит запасного вратаря на поле. Второй голкипер #{@keep_new.name} выходит на поле, а покидает его #{@team_defend[pl2].name}."
      puts act_next[j]; puts zamena; sleep 3
      @team_defend.delete(@team_defend[pl2]); @keeper_defend=@keep_new; @keep_new.games_plus(1)
      classification=15
    else
      action_next=["Нападающий решает испытать вратаря на прочность, но промахивается по воротам!", "Атакующий игрок оскальзнулся на мокрой траве и мяч отдал вратарю. Для этой команды атака закончена.", "Нападающий бьет, но вратарь намертво забирает мяч себе."]
      j=rand(3); puts action_next[j]; sleep 1; return
    end
  end
  puts action_next[j] if classification!=14.5 && classification!=15
  sleep 1
  if classification==1.1 || classification==2 || classification==3.3 || classification==4.2 || classification==5 || classification==7.1 || classification==6
    if @team_defend[pl2].position.include?("Cd") || @team_defend[pl2].position.include?("Rd") || @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].level>49
      next_moment=["Ему пытается помешать #{@team_defend[pl2].name} из команды #{@nam_defend}.", "#{@team_defend[pl2].name} из команды #{@nam_defend} делает попытку отобрать мяч у соперника!"]
      j=rand(2); puts next_moment[j]; sleep 1
      count=rand(10)
      if @team_defend[pl2].level>@team_attack[pl1].level || count<=6 || @team_defend[pl1].specialskills.include?("Пд") || @team_defend[pl1].specialskills.include?("Пр")
        next_moment=["Перехват! Для атакующей команды мяч потерян!", "Успешный отбор! Мяч потерян.", "Жестко ставит ногу защитник и успешно отбирает мяч!"]
        j=rand(3); puts next_moment[j]; sleep 1; return
      else
        next_moment=["Отбор не удался, нападающий продолжает движение с мячом!", "#{@team_attack[pl1].name} прорывается к воротам!"]
        j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
        if count<=3 || @team_attack[pl1].specialskills.include?("Ск")
          next_moment=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади! Он готовится выполнить удар!"]
          j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
          if count<=3 || @team_attack[pl1].level>=80 || @keeper_defend.level<@team_attack[pl1].level && @team_attack[pl1].specialskills.include?("Уд")
            next_moment=["Удар потрясающий по силе и точности! ГОЛ!", "Вратарь оказался не готов к такому развитию событий. Гол забит!", "Рикошет от защитника и мяч в воротах!", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
            j=rand(4); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          elsif count==4 || count==8 || @keeper_defend.level>=60
            next_moment=["Мяч ударяется об защитника и летит на угловой.", "#{@keeper_defend.name} обладает отличной реакцией! Перевел мяч на угловой! Выручил свою команду!", "Голкипер вытащил неберущийся удар из-под перекладины! Угловой!"]
            j=rand(3); puts next_moment[j]; sleep 1; count=rand(6000)
            pl_old1=pl1
            while pl_old1==pl1
              pl1=rand(num1)
            end
            if count==4889 || count==5123
              next_moment="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
              puts next_moment; sleep 1
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            else
              pl_at=rand(num1)
              if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
                next_moment=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
                j=rand(3); puts next_moment[j]; sleep 1
                pl_old1=pl1
                while pl_old1==pl1
                  pl1=rand(num1)
                end
                if @team_attack[pl1].specialskills.include?("Уд") && @team_attack[pl1].level>=70 && @team_attack[pl1].level>@keeper_defend.level
                  next_moment=["Потрясающий удар головой! Вратарь бессилен! #{@team_attack[pl1].name} забивает ГОЛ!", "#{@team_attack[pl1].name} бьет через себя! Вратарь не дотягивается ГОЛ!"]
                  j=rand(2); puts next_moment; sleep 1
                  @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                  @nam_attack==team1 ? @home+=1 : @guest+=1
                  3.times do
                    print "ГОЛ! "; sleep 2
                  end
                  puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
                else
                  next_moment=["Вратарь намертво в прыжке забирает мяч!", "Вратарь отбивает этот удар! Защитники тут как тут, выбивают мяч подальше от ворот!"]
                  j=rand(2); puts next_moment[j]; sleep 1; return
                end
              else
                new_count=rand(600)
                if new_count==1
                  next_moment=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
                  j=rand(3); puts next_moment[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
                else
                  next_moment=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
                  j=rand(3); puts next_moment[j]; sleep 1; return
                end
              end
            end
          end
        else
          next_moment=["Нападающий решил бить издалека!", "#{@team_attack[pl1].name} бьет из-за пределов штрафной площади!"]
          j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
          if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
            action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает голкипера могучим ударом! ГОЛ!", "#{@team_attack[pl1].name} лупит по мячу! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
            j=rand(3); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            count=rand(20)
            if count==3 || count==7 || count==8
              action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "#{@team_attack[pl1].name} опасно бьет по воротам! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
              j=rand(3); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            elsif count==0 || @keeper_defend.level >= 60
              action_next=["Голкипер среагировал на этот мощный удар! Защитники тоже не зевают и выносят мяч!", "Голкипер намертво берет этот удар!", "Штанга звенит!!! А от неё мяч уходит за лицевую линию."]
              j==rand(3); puts action_next[j]; sleep 1; return
            elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
              pl_old1=pl1
              while pl_old1==pl1
                pl1=rand(num1)
              end
              action_next=["Мяч угодил в штангу! Им завладела обороняющаяся команда.", "Мяч свалился с ноги нападающего, удар уж очень неточный вышел."]
              j=rand(3); puts action_next[j]; sleep 1; return
            else
              pl_old1=pl1
              while pl_old1==pl1
                pl1=rand(num1)
              end
              action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
              j==rand(3); puts action_next[j]; sleep 1
              count=rand(20)
              if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
                action_next=["Первый на мяче #{@team_attack[pl1].name}! Он закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает кипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! #{@team_attack[pl1].name} бьет в прыжке головой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
                j=rand(3); puts action_next[j]; sleep 1
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              else
                action_next=["Удар неудался, вратарь без проблем взял этот мяч! В таком случае говорят, что виноват пасующий.", "Защитники заблокировали удар из штрафной!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
                j=rand(3); puts action_next[j]; sleep 1; return
              end
            end
          end
        end
      end
    elsif @team_attack[pl1].level>@team_defend[pl2].level || @team_attack[pl1].specialskills.include?("Ск") || @team_attack[pl1].specialskills.include?("Тх")
      next_moment=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
      j=rand(2); puts next_moment[j]; sleep 1
      if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
        action_next=["#{@team_attack[pl1].name} закручивает мяч в дальний угол ворот! Ни один вратарь мира не взял бы такой удар! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит мимо защитника! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой, едва не порвав сетку! #{@team_attack[pl1].name} забивает ГОЛ!"]
        j=rand(3); puts action_next[j]
        @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
        @nam_attack==team1 ? @home+=1 : @guest+=1
        3.times do
          print "ГОЛ! "; sleep 2
        end
        puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
      else
        count=rand(20)
        if count==3 || count==7 || count==8
          action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
          j=rand(3); puts action_next[j]
          @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
          @nam_attack==team1 ? @home+=1 : @guest+=1
          3.times do
            print "ГОЛ! "; sleep 2
          end
          puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
        elsif count==0 || @keeper_defend.level >= 60
          action_next=["Голкипер среагировал на этот мощный удар! Защитники тоже не зевают и выносят мяч!", "Голкипер намертво берет этот удар!", "Штанга звенит!!! А от неё мяч уходит за лицевую линию."]
          j==rand(3); puts action_next[j]; sleep 1; return
        elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
          action_next=["Мяч угодил в защитника и перехвачен.", "Защитник блокирует этот удар!"]
          j=rand(3); puts action_next[j]; sleep 1; return
        else
          action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
          j==rand(3); puts action_next[j]; sleep 1
          count=rand(20)
          pl_old1=pl1
          while pl_old1==pl1
            pl1=rand(num1)
          end
          if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
            action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
            j=rand(3); puts action_next[j]; sleep 1
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитники заблокировали этот удар!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
            j=rand(3); puts action_next[j]; sleep 1; return
          end
        end
      end
    end
  elsif classification==1.2
    count=rand(10)
    if @team_defend[pl2].level>@team_attack[pl1].level || count<=6 || @team_defend[pl1].specialskills.include?("Пд") || @team_defend[pl1].specialskills.include?("Пр")
      next_moment=["Перехват! Для атакующей команды мяч потерян!", "Успешный отбор! Мяч потерян.", "Жестко ставит ногу защитник и успешно отбирает мяч!"]
      j=rand(3); puts next_moment[j]; sleep 1; return
    else
      next_moment=["Отбор не удался, нападающий продолжает движение с мячом!", "#{@team_attack[pl1].name} прорывается к воротам!"]
      j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
      if count<=3 || @team_attack[pl1].specialskills.include?("Ск")
        next_moment=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади! Он готовится выполнить удар!"]
        j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
       if count<=3 || @team_attack[pl1].level>=80 || @keeper_defend.level<@team_attack[pl1].level && @team_attack[pl1].specialskills.include?("Уд")
          next_moment=["Удар потрясающий по силе и точности! ГОЛ!", "Вратарь оказался не готов к такому развитию событий. Гол забит!", "Рикошет от защитника и мяч в воротах!", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
          j=rand(4); puts action_next[j]
          @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
          @nam_attack==team1 ? @home+=1 : @guest+=1
          3.times do
            print "ГОЛ! "; sleep 2
          end
          puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
        elsif count==4 || count==8 || @keeper_defend.level>=60
          next_moment=["Мяч ударяется об защитника и летит на угловой.", "#{@keeper_defend.name} обладает отличной реакцией! Перевел мяч на угловой! Выручил свою команду!", "Голкипер вытащил неберущийся удар из-под перекладины! Угловой!"]
          j=rand(3); puts next_moment[j]; sleep 1; count=rand(6000)
          pl_old1=pl1
          while pl_old1==pl1
            pl1=rand(num1)
          end
          if count==4889 || count==5123
            next_moment="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
            puts next_moment; sleep 1
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            pl_at=rand(num1)
            if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
              next_moment=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
              j=rand(3); puts next_moment[j]; sleep 1
              pl_old1=pl1
              while pl_old1==pl1
                pl1=rand(num1)
              end
              if @team_attack[pl1].specialskills.include?("Уд") && @team_attack[pl1].level>=70 && @team_attack[pl1].level>@keeper_defend.level
                next_moment=["Потрясающий удар головой! Вратарь бессилен! #{@team_attack[pl1].name} забивает ГОЛ!", "#{@team_attack[pl1].name} бьет через себя! Вратарь не дотягивается ГОЛ!"]
                j=rand(2); puts next_moment; sleep 1
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              else
                next_moment=["Вратарь намертво в прыжке забирает мяч!", "Вратарь отбивает этот удар! Защитники тут как тут, выбивают мяч подальше от ворот!"]
                j=rand(2); puts next_moment[j]; sleep 1; return
              end
            else
              new_count=rand(600)
              if new_count==1
                next_moment=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
                j=rand(3); puts next_moment[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
              else
                next_moment=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
                j=rand(3); puts next_moment[j]; sleep 1; return
              end
            end
          end
        end
      else
        next_moment=["Нападающий решил бить издалека!", "#{@team_attack[pl1].name} бьет из-за пределов штрафной площади!"]
        j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
        if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
          action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
          j=rand(3); puts action_next[j]
          @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
          @nam_attack==team1 ? @home+=1 : @guest+=1
          3.times do
            print "ГОЛ! "; sleep 2
          end
          puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
        else
          count=rand(20)
          if count==3 || count==7 || count==8
            action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
            j=rand(3); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          elsif count==0 || @keeper_defend.level >= 60
            action_next=["Голкипер среагировал на этот мощный удар! Защитники тоже не зевают и выносят мяч!", "Голкипер намертво берет этот удар!", "Штанга звенит!!! А от неё мяч уходит за лицевую линию."]
            j==rand(3); puts action_next[j]; sleep 1; return
          elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
            pl_old1=pl1
            while pl_old1==pl1
              pl1=rand(num1)
            end
            action_next=["Мяч угодил в штангу! Им завладела обороняющаяся команда.", "Мяч свалился с ноги нападающего, удар уж очень неточный вышел."]
            j=rand(3); puts action_next[j]; sleep 1; return
          else
            pl_old1=pl1
            while pl_old1==pl1
              pl1=rand(num1)
            end
            action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
            j==rand(3); puts action_next[j]; sleep 1
            count=rand(20)
            if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
              action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает кипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
              j=rand(3); puts action_next[j]; sleep 1
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            else
              action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитники заблокировали этот удар!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
              j=rand(3); puts action_next[j]; sleep 1; return
            end
          end
        end
      end
    end
  elsif classification==1.3 || classification==7.3
    count=rand(10)
    if count<=4 && @team_attack[pl1].level>59 && @team_attack[pl_old1].level>54
      action_next=["Мяч успешно дошел до адресата! #{@team_attack[pl1].name} принимает его и несется к штрафной!", "#{@team_attack[pl1].name} принимает пас и на всех парах мчится к штрафной!"]
      j=rand(2); puts action_next[j]; sleep 1
      if @team_defend[pl2].level > @team_attack[pl1].level || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Cd") || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].level >= 75 && @team_defend[pl2].position.include?("Rd")
        action_next=["#{@team_defend[pl2].name} из команды #{@nam_defend} отчаянно бросается в подкат!", "#{@team_defend[pl2].name} из команды #{@nam_defend} пытается отобрать мяч!"]
        j=rand(2); puts action_next[j]; count=rand(10)
        if count==2 || @team_attack[pl1].level>=80 && @keeper_defend.level < @team_attack[pl1].level || @team_attack[pl1].specialskills.include?("Тх") || @team_attack[pl1].level>=62 && @team_attack[pl1].specialskills.include?("Ск")
          action_next=["Прекрасный дриблинг демонстрирует нам #{@team_attack[pl1].name}! Он прокидывает мяч между двух защитников! Выход один на один!", "Отличная техника. Вот у него бы поучиться владеть мячом, осталось последнего защитника обыграть.", "Потрясающий финт по сложности и красоте! Он выходит к воротам и намеревается бить!", "Он прицеливается и бьет!"]
          j=rand(4); puts action_next[j]; sleep 1; pl_old1=pl1
          while pl_old1==pl1
            pl1=rand(num1)
          end
          gonz=rand(15)
          if gonz<=7 && (@team_attack[pl1].specialskills.include?("Од") || (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Ск")) && @team_attack[pl1].level>64 || @team_attack[pl1].level>@keeper_defend.level)
            action_next=["Следует сближение с вратарем и удар потрясающий по силе и точности! ГОЛ-красавец! Девятка! Автор - #{@team_attack[pl1].name}.", "Вратарь оказался не готов к такому развитию событий. #{@team_attack[pl1].name} перебрасывает мяч через него! ГОЛ!", "Вратарь дотягивается до мяча, однако он все равно оказывается в воротах! #{@team_attack[pl1].name} записан как автор гола.", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
            j=rand(4); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          elsif gonz==8 || gonz==9
            action_next=["Вратарь идет на сближение с нападающим и бросается ему в ноги! Фол последней надежды! Удаление вратаря и пенальти!", "Вратарь фолит на нападающем и удаляется с поля! Справедливый пенальти!"]
            j=rand(2); @keeper_defend.redcards(1)
            @keep_new=@team_element1.status[1][0][0]; pl2=rand(num2)
            zamena="Основной вратарь удален. Тренер выводит запасного вратаря на поле. Второй голкипер #{@keep_new.name} выходит на поле, а покидает его #{@team_defend[pl2].name}."
            puts action_next[j]; sleep 1; puts zamena; sleep 3
            @team_defend.delete(@team_defend[pl2]); @keeper_defend=@keep_new; @keep_new.games_plus(1)
            pl1=rand(num1)
            puts "Пенальти готовится пробить #{@team_attack[pl1].name}."; sleep 2; proc=rand(100)
            if proc<=43 || @team_attack[pl1].specialskills.include?("Пн") || @team_attack[pl1].level>@keeper_defend.level && (@team_attack[pl1].position.include?("Rf") || @team_attack[pl1].position.include?("Cf") || @team_attack[pl1].position.include?("Lf") || @team_attack[pl1].position.include?("St") || @team_attack[pl1].position.include?("Cam"))
              action_next=["#{@team_attack[pl1].name} пробил в правый угол! Вратарь даже не шелохнулся! Потрясающий ГОЛ!", "#{@team_attack[pl1].name} сильно пробил по центру, вратарь оказался к такому не готов! ГОЛ!", "#{@team_attack[pl1].name} плотно пробил в левый нижний угол! Вратарь даже не дернулся! ГОЛ!", "#{@team_attack[pl1].name} пробил в правую девятку! Вратарь угадал направление, но мяч не достал. ГОЛ!"]
              j=rand(4); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            else
              action_next=["#{@keeper_defend.name} берет этот удар! Потрясающий сейв!", "#{keeper_defend.name} совершил молниеносный бросок в левый угол и отразил мощнейший удар!", "#{keeper_defend.name} берет этот пенальти!!! Отменная реакция!", "Нападающий готовится... Разбег! Удар! Потрясающий сейв совершает #{keeper_defend.name}!!! Намертво забирает мяч!"]
              j=rand(4); puts action_next[j]; sleep 1; return
            end
          else
            action_next=["Нападающий решает испытать вратаря на прочность, но промахивается по воротам!", "Атакующий игрок оскальзнулся на мокрой траве и мяч отдал вратарю. Для этой команды атака закончена.", "Нападающий бьет, но вратарь намертво забирает мяч себе."]
            j=rand(3); puts action_next[j]; sleep 1; return
          end
        elsif (count==1 || count==4 || count==6 || count==8) && (!@team_defend[pl2].specialskills.include?("Пд") || !@team_attack[pl1].specialskills.include?("Пр")) || @team_defend[pl2].level<=74
          newcount=rand(5); srand=rand(8); injur1=rand(12)
          if newcount>=3
            action_next=["Один из защитников, а точнее, #{@team_defend[pl2].name}, фолит на нападающем. Впрочем, нарушение не серьёзное, и только штрафной.", "Нападающего сбивают, однако карточки нет. Штрафной удар.", "Подножка от игрока обороны, однако арбитр всего лишь дает штрафной удар в непосредственной близости от ворот.", "Фол рядом с штрафной!!! Будет ли карточка?.. Нет, судья отделался лишь устным предупреждением."]
            j=rand(4); puts action_next[j]; sleep 1
          elsif srand<=2
            action_next=["Фол последней надежды. #{@team_defend[pl2].name} совершенно справедливо удален с поля. Судья дает пенальти!", "Прямой ногой идет в стык с нападающим #{@team_defend[pl2].name}. Судья бежит к месту событий... Красная карточка и пенальти!", "#{@team_defend[pl2].name} хватает нападающего за футболку, он картинно падает, однако судья купился на эту уловку. И.. удаляет игрока защиты! Обороняющаяся команда в меньшинстве будет! Да еще и пенальти назначается!"]
            j=rand(3); @team_defend[pl2].redcards(1); @team_defend.delete(@team_defend[pl2])
            puts action_next[j]; sleep 1
          else
            action_next=["Грубый подкат сбоку в исполнении защитника. #{@team_defend[pl2].name} получает желтую карточку. Назначен штрафной.", "Штрафной удар назначен в пользу атакующей команды благодаря грубому подкату игрока защиты. За этот подкат #{@team_defend[pl2].name} получает горчичник.", "Последовал подкат, #{@team_attack[pl1].name} корчится на газоне от боли... #{@team_defend[pl2].name} получает желтую. Прав судья, по-моему.", "#{@team_defend[pl2].name} делает подножку сопернику, за что и наказывается желтой карточкой."]
            j=rand(4); puts action_next[j]; sleep 1; @team_defend[pl2].yellowcards(1); rej=@team_defend[pl2].yel_cards
            if rej==2
              puts "Это вторая желтая карточка для этого игрока. #{@team_defend[pl2].name} пытается безуспешно спорить с арбитром. Его удаляют с поля."
              @team_defend[pl2].redcards(1); @team_defend.delete(@team_defend[pl2]); num2=rand(@team_defend.size)
            end
          end
          count=rand(10)
          if count<=3 || @team_attack[pl1].level>@keeper_defend.level
            action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
            j=rand(3); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            count=rand(20)
            if count==3 || count==7 || count==8
              action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
              j=rand(3); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            elsif count==0 || @keeper_defend.level >= 60 || count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
              action_next=["Мяч угодил в стенку и им завладели соперники.", "После неочень удачной подачи в борьбу мяч потерян для атакующей команды."]
              j=rand(3); puts action_next[j]; sleep 1; return
            else
              action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
              j==rand(3); puts action_next[j]; sleep 1
              count=rand(20)
              if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
                action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает кипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
                j=rand(3); puts action_next[j]; sleep 1
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              else
                action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитники заблокировали этот удар!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
                j=rand(3); puts action_next[j]; sleep 1; return
              end
            end
          end  
        end
        if injur1==5 || injur1==6 || injur1==8 || injur1==11
          mat=rand(6)+1
          if mat==1
            sr="у."
          elsif mat==2 || mat==3 || mat==4
            sr="ы."
          else
            sr="."
          end
          action_inj=["#{@team_attack[pl1].name} получает травму и выбывает на #{mat} игр#{sr}", "#{@team_attack[pl1].name} получает досадную травму и выбывает на #{mat} игр#{sr}", "Серьезную травму после столкновения с соперником получает #{@team_attack[pl1].name}. Он выбывает на #{mat} игр#{sr}"]
          ker=rand(3)
          @team_attack[pl1].position.size==1 ? fact=@team_attack[pl1].position[0] : fact=@team_attack[pl1].position[0]
          for i in 0...@team_element1.status[1].size
            for k in 0...@team_element1.status[1][i].size
              if @team_element1.status[1][i][k].position.include?(fact)
                @pl1_new=@team_element1.status[1][i][k]; break
              end
            end
          end
          puts action_next[j]; puts action_inj[ker]; puts "#{@pl1_new.name} >>"; puts "<< #{@team_attack[pl1].name}"
          @team_attack[pl1].injure(mat); @team_attack[pl1]=@pl1_new; @pl1_new.games_plus(1); pl1=rand(num1)
        end
      else
        action_next=["К сожалению для нападающего, дриблинг не удался. Мяч потерян.", "#{@team_defend[pl2].name} отбирает мяч и выносит подальше!", "Защитники остановили нападающего!"]
        j=rand(3); puts action_next[j]; sleep 1; return
      end
    else
      action_next=["#{@team_attack[pl1].name} беспрепятственно проходит игроков соперника одного за другим!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
      j=rand(2); puts action_next[j]; sleep 1
      if @team_defend[pl2].position.include?("Cd") || @team_defend[pl2].position.include?("Rd") || @team_defend[pl2].position.include?("Ld") || @team_defend[pl2].level>49
        next_moment=["Ему пытается помешать #{@team_defend[pl2].name} из команды #{@nam_defend}.", "#{@team_defend[pl2].name} из команды #{@nam_defend} делает попытку отобрать мяч у соперника!"]
        j=rand(2); puts next_moment[j]; sleep 1
        count=rand(10)
        if @team_defend[pl2].level>@team_attack[pl1].level || count<=6 || @team_defend[pl1].specialskills.include?("Пд") || @team_defend[pl1].specialskills.include?("Пр")
          next_moment=["Перехват! Для атакующей команды мяч потерян!", "Успешный отбор! Мяч потерян.", "Жестко ставит ногу защитник и успешно отбирает мяч!"]
          j=rand(3); puts next_moment[j]; sleep 1; return
        elsif
          next_moment=["Отбор не удался, нападающий продолжает движение с мячом!", "#{@team_attack[pl1].name} прорывается к воротам!"]
          j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
          if count<=3 || @team_attack[pl1].specialskills.include?("Ск")
            next_moment=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади! Он готовится выполнить удар!"]
            j=rand(2); puts next_moment[j]; sleep 1; count=rand(10)
            if count<=3 || @team_attack[pl1].level>=80 || @keeper_defend.level<@team_attack[pl1].level && @team_attack[pl1].specialskills.include?("Уд")
              next_moment=["Удар потрясающий по силе и точности! ГОЛ!", "Вратарь оказался не готов к такому развитию событий. Гол забит!", "Рикошет от защитника и мяч в воротах!", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
              j=rand(4); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            elsif count==4 || count==8 || @keeper_defend.level>=60
              next_moment=["Мяч ударяется об защитника и летит на угловой.", "#{@keeper_defend.name} обладает отличной реакцией! Перевел мяч на угловой! Выручил свою команду!", "Голкипер вытащил неберущийся удар из-под перекладины! Угловой!"]
              j=rand(3); puts next_moment[j]; sleep 1; count=rand(6000)
              pl_old1=pl1
              while pl_old1==pl1
                pl1=rand(num1)
              end
              if count==4889 || count==5123
                next_moment="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
                puts next_moment; sleep 1
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              else
                pl_at=rand(num1)
                if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
                  next_moment=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
                  j=rand(3); puts next_moment[j]; sleep 1
                  pl_old1=pl1
                  while pl_old1==pl1
                    pl1=rand(num1)
                  end
                  if @team_attack[pl1].specialskills.include?("Уд") && @team_attack[pl1].level>=70 && @team_attack[pl1].level>@keeper_defend.level
                    next_moment=["Потрясающий удар головой! Вратарь бессилен! #{@team_attack[pl1].name} забивает ГОЛ!", "#{@team_attack[pl1].name} бьет через себя! Вратарь не дотягивается ГОЛ!"]
                    j=rand(2); puts next_moment; sleep 1
                    @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                    @nam_attack==team1 ? @home+=1 : @guest+=1
                    3.times do
                      print "ГОЛ! "; sleep 2
                    end
                    puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
                  else
                    next_moment=["Вратарь намертво в прыжке забирает мяч!", "Вратарь отбивает этот удар! Защитники тут как тут, выбивают мяч подальше от ворот!"]
                    j=rand(2); puts next_moment[j]; sleep 1; return
                  end
                else
                  new_count=rand(600)
                  if new_count==1
                    next_moment=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
                    j=rand(3); puts next_moment[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
                  else
                    next_moment=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
                    j=rand(3); puts next_moment[j]; sleep 1; return
                  end
                end
              end
            end
          else
            next_moment=["Нападающего вновь оттесняют за пределы штрафной! Он решил бить издалека!"]
            j=0; puts next_moment[j]; sleep 1; count=rand(10)
            if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
              action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
              j=rand(3); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            else
              count=rand(20)
              if count==3 || count==7 || count==8
                action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
                j=rand(3); puts action_next[j]
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              elsif count==0 || @keeper_defend.level >= 60
                action_next=["Голкипер среагировал на этот мощный удар! Защитники тоже не зевают и выносят мяч!", "Голкипер намертво берет этот удар!", "Штанга звенит!!! А от неё мяч уходит за лицевую линию."]
                j==rand(3); puts action_next[j]; sleep 1; return
              elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
                pl_old1=pl1
                while pl_old1==pl1
                  pl1=rand(num1)
                end
                action_next=["Мяч угодил в штангу! Им завладела обороняющаяся команда.", "Мяч свалился с ноги нападающего, удар уж очень неточный вышел."]
                j=rand(3); puts action_next[j]; sleep 1; return
              else
                pl_old1=pl1
                while pl_old1==pl1
                  pl1=rand(num1)
                end
                action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
                j==rand(3); puts action_next[j]; sleep 1
                count=rand(20)
                if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
                  action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает кипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
                  j=rand(3); puts action_next[j]; sleep 1
                  @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                  @nam_attack==team1 ? @home+=1 : @guest+=1
                  3.times do
                    print "ГОЛ! "; sleep 2
                  end
                  puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
                else
                  action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитники заблокировали этот удар!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
                  j=rand(3); puts action_next[j]; sleep 1; return
                end
              end
            end
          end
        elsif @team_attack[pl1].level>@team_defend[pl2].level || @team_attack[pl1].specialskills.include?("Ск") || @team_attack[pl1].specialskills.include?("Тх")
          next_moment=["#{@team_attack[pl1].name} уже в штрафной! Будет удар!", "Рубежи обороны соперника взломаны! #{@team_attack[pl1].name} уже на подступах к штрафной площади!"]
          j=rand(2); puts next_moment[j]; sleep 1
          if @keeper_defend.level < @team_attack[pl1].level && (@team_attack[pl1].specialskills.include?("Уд") || @team_attack[pl1].specialskills.include?("Шт"))
            action_next=["#{@team_attack[pl1].name} закручивает мяч в дальний угол ворот! Ни один вратарь мира не взял бы такой удар! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит мимо защитника! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой, едва не порвав сетку! #{@team_attack[pl1].name} забивает ГОЛ!"]
            j=rand(3); puts action_next[j]
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            count=rand(20)
            if count==3 || count==7 || count==8
              action_next=["#{@team_attack[pl1].name} закручивает мяч в ближнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает вратаря могучим ударом! ГОЛ!", "Мяч летит над защитником! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищной силой! #{@team_attack[pl1].name} забивает ГОЛ!"]
              j=rand(3); puts action_next[j]
              @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
              @nam_attack==team1 ? @home+=1 : @guest+=1
              3.times do
                print "ГОЛ! "; sleep 2
              end
              puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
            elsif count==0 || @keeper_defend.level >= 60
              action_next=["Голкипер среагировал на этот мощный удар! Защитники тоже не зевают и выносят мяч!", "Голкипер намертво берет этот удар!", "Штанга звенит!!! А от неё мяч уходит за лицевую линию."]
              j==rand(3); puts action_next[j]; sleep 1; return
            elsif count==1 || count==2 || count==4 || count==6 || count==9 || count==10 || count==11 || count==13 || count==17
              action_next=["Мяч угодил в защитника и перехвачен.", "Защитник блокирует этот удар!"]
              j=rand(3); puts action_next[j]; sleep 1; return
            else
              action_next=["Опасная подача в штрафную! Будет ли удар?", "Высокая подача в штрафную площадь. Кто окажется первым на мяче?", "Решили разыграть штрафной, что из этого выйдет?"]
              j==rand(3); puts action_next[j]; sleep 1
              count=rand(20)
              pl_old1=pl1
              while pl_old1==pl1
                pl1=rand(num1)
              end
              if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
                action_next=["#{@team_attack[pl1].name} закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает стенку могучим ударом! ГОЛ!", "Мяч летит над стенкой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
                j=rand(3); puts action_next[j]; sleep 1
                @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
                @nam_attack==team1 ? @home+=1 : @guest+=1
                3.times do
                  print "ГОЛ! "; sleep 2
                end
                puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
              else
                action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитники заблокировали этот удар!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
                j=rand(3); puts action_next[j]; sleep 1; return
              end
            end
          end
        end
      end
    end
  elsif classification==15 || classification==14.3
    pl1=rand(num1)
    puts "Пенальти готовится пробить #{@team_attack[pl1].name}."; sleep 2; proc=rand(100)
    if proc<=43 || @team_attack[pl1].specialskills.include?("Пн") || @team_attack[pl1].level>@keeper_defend.level && (@team_attack[pl1].position.include?("Rf") || @team_attack[pl1].position.include?("Cf") || @team_attack[pl1].position.include?("Lf") || @team_attack[pl1].position.include?("St") || @team_attack[pl1].position.include?("Cam"))
      action_next=["#{@team_attack[pl1].name} пробил в правый угол! Вратарь даже не шелохнулся! Потрясающий ГОЛ!", "#{@team_attack[pl1].name} сильно пробил по центру, вратарь оказался к такому не готов! ГОЛ!", "#{@team_attack[pl1].name} плотно пробил в левый нижний угол! Вратарь даже не дернулся! ГОЛ!", "#{@team_attack[pl1].name} пробил в правую девятку! Вратарь угадал направление, но мяч не достал. ГОЛ!"]
      j=rand(4); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      action_next=["#{@keeper_defend.name} берет этот удар! Потрясающий сейв!", "#{keeper_defend.name} совершил молниеносный бросок в левый угол и отразил мощнейший удар!", "#{keeper_defend.name} берет этот пенальти!!! Отменная реакция!", "Нападающий готовится... Разбег! Удар! Потрясающий сейв совершает #{keeper_defend.name}!!! Намертво забирает мяч!"]
      j=rand(4); puts action_next[j]; sleep 1; return
    end
  elsif classification==14.2 || classification==14.4
    #Штрафной удар
  elsif classification==14.1
    count=rand(10)
    if count<=3 || @team_attack[pl1].level>=80 || @keeper_defend.level<@team_attack[pl1].level && @team_attack[pl1].specialskills.include?("Уд")
      next_moment=["Удар потрясающий по силе и точности! ГОЛ!", "Вратарь оказался не готов к такому развитию событий. Гол забит!", "Рикошет от защитника и мяч в воротах!", "Красивейший удар... Мяч сотрясает перекладину и оказывается в воротах! #{@team_attack[pl1].name} забивает гол!"]
      j=rand(4); puts action_next[j]
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    elsif count==4 || count==8 || @keeper_defend.level>=60
      next_moment=["Мяч ударяется об защитника и летит на угловой.", "#{@keeper_defend.name} обладает отличной реакцией! Перевел мяч на угловой! Выручил свою команду!", "Голкипер вытащил неберущийся удар из-под перекладины! Угловой!"]
      j=rand(3); puts next_moment[j]; sleep 1; count=rand(6000)
      pl_old1=pl1
      while pl_old1==pl1
        pl1=rand(num1)
      end
      if count==4889 || count==5123
        next_moment="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
        puts next_moment; sleep 1
        @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
        @nam_attack==team1 ? @home+=1 : @guest+=1
        3.times do
          print "ГОЛ! "; sleep 2
        end
        puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
      else
        pl_at=rand(num1)
        if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
          next_moment=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
          j=rand(3); puts next_moment[j]; sleep 1
          pl_old1=pl1
          while pl_old1==pl1
            pl1=rand(num1)
          end
          if @team_attack[pl1].specialskills.include?("Уд") && @team_attack[pl1].level>=70 && @team_attack[pl1].level>@keeper_defend.level
            next_moment=["Потрясающий удар головой! Вратарь бессилен! #{@team_attack[pl1].name} забивает ГОЛ!", "#{@team_attack[pl1].name} бьет через себя! Вратарь не дотягивается ГОЛ!"]
            j=rand(2); puts next_moment; sleep 1
            @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
            @nam_attack==team1 ? @home+=1 : @guest+=1
            3.times do
              print "ГОЛ! "; sleep 2
            end
            puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
          else
            next_moment=["Вратарь намертво в прыжке забирает мяч!", "Вратарь отбивает этот удар! Защитники тут как тут, выбивают мяч подальше от ворот!"]
            j=rand(2); puts next_moment[j]; sleep 1; return
          end
        else
          new_count=rand(600)
          if new_count==1
             next_moment=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
            j=rand(3); puts next_moment[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
          else
            next_moment=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
            j=rand(3); puts next_moment[j]; sleep 1; return
          end
        end
      end
    end
  elsif classification==11.2 || classification==12.2
    count=rand(20)
    if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
      action_next=["Первый на мяче #{@team_attack[pl1].name}! Он закручивает мяч в дальнюю девятку! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар исполняет #{@team_attack[pl1].name}! Он прошивает кипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! #{@team_attack[pl1].name} бьет в прыжке головой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
      j=rand(3); puts action_next[j]; sleep 1
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      action_next=["Удар неудался, вратарь без проблем взял этот мяч! В таком случае говорят, что виноват пасующий.", "Защитники заблокировали удар из штрафной!", "Защитники один за другим ложатся под мяч, не давая ему проникнуть во вратарскую площадь!"]
      j=rand(3); puts action_next[j]; sleep 1; return
    end
  elsif classification==10
    count=rand(20)
    if count<=4 || @team_attack[pl1].level>@keeper_defend.level && @team_attack[pl1].level>79
      action_next=["#{@team_attack[pl1].name} кивком головы отправляет мяч под перекладину! Вратарь бессилен! ГОЛ!", "Потрясающий по силе и точности удар головой в прыжке исполняет #{@team_attack[pl1].name}! Он прошивает голкипера могучим ударом! ГОЛ!", "Мяч летит над штрафной площадью! #{@team_attack[pl1].name} бьет в прыжке головой! Вратарь... не дотягивается до мяча, и он влетает в ворота с чудовищний силой! ГОЛ!"]
      j=rand(3); puts action_next[j]; sleep 1
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      action_next=["Удар неудался, вратарь без проблем взял этот мяч!", "Защитник блокирует удар!", "Защитник на ленточке выносит этот мяч!"]
      j=rand(3); puts action_next[j]; sleep 1; return
    end
  elsif classification==8.2 || classification==9
    #
  elsif classification==8.1
    #
  elsif classification==7.2
    #
  elsif classification==7.3
    #
  elsif classification==3.2
    #
  elsif classification==4.1
    #
  elsif classification==11.1 || classification==12.1 || classification==13
    count=rand(6000); pl_old1=pl1
    while pl_old1==pl1
      pl1=rand(num1)
    end
    if count==4889 || count==5123
      next_moment="#{@team_attack[pl1].name} закручивает мяч с углового прямо в ворота! ГОЛ!"
      puts next_moment; sleep 1
      @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
      @nam_attack==team1 ? @home+=1 : @guest+=1
      3.times do
        print "ГОЛ! "; sleep 2
      end
      puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
    else
      pl_at=rand(num1)
      if @team_attack[pl1].specialskills.include?("Уг") || @team_attack[pl1].specialskills.include?("Нв") || count==1 || count==3
        next_moment=["#{@team_attack[pl_at].name} бьет головой!", "#{@team_attack[pl_at].name} в прыжке опережает всех и бьет!", "#{@team_attack[pl_at].name} бьет с лету!"]
        j=rand(3); puts next_moment[j]; sleep 1
        pl_old1=pl1
        while pl_old1==pl1
          pl1=rand(num1)
        end
        if @team_attack[pl1].specialskills.include?("Уд") && @team_attack[pl1].level>=70 && @team_attack[pl1].level>@keeper_defend.level
          next_moment=["Потрясающий удар головой! Вратарь бессилен! #{@team_attack[pl1].name} забивает ГОЛ!", "#{@team_attack[pl1].name} бьет через себя! Вратарь не дотягивается ГОЛ!"]
          j=rand(2); puts next_moment; sleep 1
          @team_attack[pl1].goals_score(1); @keeper_defend.goals_concede(1)
          @nam_attack==team1 ? @home+=1 : @guest+=1
          3.times do
            print "ГОЛ! "; sleep 2
          end
          puts "#{team1} - #{team2} #{@home} - #{@guest}"; sleep 2; return
        else
          next_moment=["Вратарь намертво в прыжке забирает мяч!", "Вратарь отбивает этот удар! Защитники тут как тут, выбивают мяч подальше от ворот!"]
          j=rand(2); puts next_moment[j]; sleep 1; return
        end
      else
        new_count=rand(600)
        if new_count==1
          next_moment=["#{@team_defend[pl2].name} из команды #{@nam_defend} снова выбивает мяч на угловой.", "#{@team_defend[pl2].name} из команды #{@nam_defend} в отчаянном прыжке снова переводит мяч на угловой.", "Подача отвратительно исполнена, но игроки защиты вовремя не соориентировались и один из них отправил мяч за лицевую линию. Угловой!"]
          j=rand(3); puts next_moment[j]; sleep 1; puts "Этот угловой, к сожалению, заканчивается ничем для атакующей команды."; sleep 1; return
        else
          next_moment=["Для атакующей команды эта атака закончилась ничем! Мяч потерян.", "Очень неудачный навес, соперники завладели мячом.", "Безобразный прострел, и, как следствие, мяч потерян."]
          j=rand(3); puts next_moment[j]; sleep 1; return
        end
      end
    end
  end
  return
end
puts
puts "Начинается матч между командами #{team1} и #{team2}"
sleep 1
puts "Арбитр дает свисток к началу матча!"
for i in 1..45
  print "#{i}* "
  puts match_act(team1,team2); sleep 1
end
dop=rand(3)
if dop==1
  puts "45+1* Одну минуту добавил арбитр."
  puts match_act(team1,team2); sleep 1
elsif dop==2
  puts "45+1* Судья добавил две минуты к первому тайму."
  puts match_act(team1,team2); sleep 1
  print "45+2* "
  puts match_act(team1,team2); sleep 1
else
  puts "Арбитр посчитал, что ничего не нужно добавлять к первому тайму."
end
puts "\nПерерыв... #{team1} - #{team2} #{@home} - #{@guest}\n"
sleep 5
puts "Со свистком судьи начинается второй тайм!"; puts; sleep 1

for i in 45..90
  print "#{i}* "
  puts match_act(team1,team2)
  sleep 1
end
dop=rand(10)
if dop>=2 && dop<=5
  puts "90+1* Одну минуту добавил арбитр."
  puts match_act(team1,team2); sleep 1
elsif dop==6 || dop==7
  puts "90+1* Две минуты добавлены судьей к матчу."
  puts match_act(team1,team2); sleep 1
  print "90+2* "
  puts match_act(team1,team2); sleep 1
elsif dop==8 || dop==9
  puts "90+1* Рефери добавил три минуты ко второму тайму."
  puts match_act(team1,team2); sleep 1
  print "90+2* "
  puts match_act(team1,team2); sleep 1
  print "90+3* "
  puts match_act(team1,team2); sleep 1
else
  puts "Арбитр ничего не добавляет к концовке матча."
end
sleep 1
if @home>@guest
  puts "Матч окончен! Победили хозяева #{team1} со счетом #{@home} - #{@guest}"
elsif @home==@guest
  puts "Матч окончен! Ничья #{@home} - #{@guest}"
else
  puts "Матч окончен! Победа гостей #{team2} со счетом #{@home} - #{@guest}"
end
puts
