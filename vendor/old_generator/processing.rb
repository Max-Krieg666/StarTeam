# encoding:UTF-8
# Author: Max Bogoyavlenskiy (c) 2012-2013
# For Project "VFMIL" Virtual Football Manager "Soccer In Life" (c) (r)
# Здесь прописаны все параметры классов Team, Player, Coach, Stadium

include Math
class Team
  attr_reader :name, :players, :numbers
  @active=[[],[],[],[]]; @reserve=[[],[],[],[]]
  # Инициализация
  def initialize(name)
    @name=name
    @players=[[],[],[],[]]
    @reserve=[[],[],[],[]]
    @active=[[],[],[],[]]
    @numbers_in_team=[]
  end
  # Добавление игрока в команду
  def player_add(player)
    pl=player.position
    if pl.include?("Gk")
      @players[0] << player
    elsif pl.include?("Ld") || pl.include?("Cd") || pl.include?("Rd")
      @players[1] << player
    elsif pl.include?("Lm") || pl.include?("Cdm") || pl.include?("Cm") || pl.include?("Cam") || pl.include?("Rm")
      @players[2] << player
    elsif pl.include?("Lf") || pl.include?("Cf") || pl.include?("St") || pl.include?("Rf")
      @players[3] << player
    end
    @players
  end
  # Удаление игрока из команды
  def player_del(player)
    pl=player.position
    if pl==["Gk"]
      @players[0].delete(player)
    elsif pl==["Ld"] || pl==["Cd"] || pl==["Rd"]
      @players[1].delete(player)
    elsif pl==["Lm"] || pl==["Cdm"] || pl==["Cm"] || pl==["Cam"] || pl==["Rm"]
      @players[2].delete(player)
    elsif pl==["Cf"] || pl==["Rf"] || pl==["Lf"] || pl==["St"]
      @players[3].delete(player)
    end
    @players
  end
  # Сила команды
  def power
    @power=0
    for i in 0..@players.size-1
      for j in 0...@players[i].size
        @power+=@players[i][j].level
      end
    end
    @power
  end
  # Число фанатов, его уменьшение и увеличение
  def fans(numb)
    @fans=numb
  end
  def fans_total(a, b, place)
    @last_score="#{a}-#{b}"
    if a==b && a==3
      @fans+=10
    elsif a==b && a==4
      @fans+=25
    elsif a==b && a>=5
      @fans+=50
    elsif a>b && place=="home"
      @fans+=3*a*(a-b)
    elsif a>b && place=="guest"
      @fans+=6*a*(a-b)
    elsif a<b && place=="home"
      @fans-=6*b*(b-a)
    elsif a<b && place=="guest"
      @fans-=3*b*(b-a)
    end
    @fans
  end
  # Тактика
  def tactic
    de,mi,at=@active[1].size,@active[2].size,@active[3].size
    @tactic="#{de}-#{mi}-#{at}"
  end
  # Стадион
  def stadium
  end
  # Номера в команде
  def numbers_in_team
    for i in 0...@players.size
      for j in 0...@players[i].size
        @numbers_in_team << @players[i][j].number
      end
    end
    @numbers_in_team
  end
  # Тренер
  def coach
    
  end
  # Бюджет команды и операции с ним
  def budget(init)
    @budget=init
  end
  def budget_plus(sum)
    @budget+=sum
  end
  def budget_minus(sum)
    @budget-=sum
  end
  
  # Увеличение возраста и мастерства всей команде сразу
  def upgrade
    for i in 0..@players.size-1
      for j in 0...@players[i].size
        @age+=1
        if @talent<=3 || (@talent>3 && @specialskills.include?("+1опр"))
          @level+=@talent
        else
          @level+=@talent-1
        end
        if @age==40
          
        end
      end
    end
  end
  
  # Прибавление одной игры каждому из игроков основного состава.
  def game_up
    for i in 0..@players.size-1
      for j in 0...@players[i].size
        if @players[i][j].status=="active" || @players[i][j].status=="A"
          @players[i][j].games_plus(1)
        end
      end
    end
  end
  
  # Определение основного и резервного составов
  def status
    for i in 0...@players.size
      for j in 0...@players[i].size 
        #@numbers_in_team << @players[i][j].number
        if @players[i][j].status=="active" # Active, основной состав
          if @players[i][j].position.include?("Gk")
            @active[0] << @players[i][j]
          elsif @players[i][j].position.include?("Ld") || @players[i][j].position.include?("Cd") || @players[i][j].position.include?("Rd")
            @active[1] << @players[i][j]
          elsif @players[i][j].position.include?("Lm") || @players[i][j].position.include?("Cdm") || @players[i][j].position.include?("Rm") || @players[i][j].position.include?("Cam") || @players[i][j].position.include?("Cm")
            @active[2] << @players[i][j]
          elsif @players[i][j].position.include?("St") || @players[i][j].position.include?("Cf") || @players[i][j].position.include?("Lf") || @players[i][j].position.include?("Rf")
            @active[3] << @players[i][j]
          end
        elsif @players[i][j].status=="reserve" # Reserve, запасной состав
          if @players[i][j].position.include?("Gk")
            @reserve[0] << @players[i][j]
          elsif @players[i][j].position.include?("Ld") || @players[i][j].position.include?("Cd") || @players[i][j].position.include?("Rd")
            @reserve[1] << @players[i][j]
          elsif @players[i][j].position.include?("Lm") || @players[i][j].position.include?("Cdm") || @players[i][j].position.include?("Rm") || @players[i][j].position.include?("Cam") || @players[i][j].position.include?("Cm")
            @reserve[2] << @players[i][j]
          elsif @players[i][j].position.include?("St") || @players[i][j].position.include?("Cf") || @players[i][j].position.include?("Lf") || @players[i][j].position.include?("Rf")
            @reserve[3] << @players[i][j]
          end
        end
      end
    end
    return [@active, @reserve]
  end
end

class Player
  attr_reader :team, :number, :name, :country, :position, :talent, :age, :level, :price, :specialskills, :status, :injure
  #@goals_scored=0; @redcards=0; @yellowcards=0; @games=0; @goals_conceded=0; @play=true; @injure=0, @yel_cards=0
  # Инициализация
  def initialize(team, number, name, country, position, talent, age, level, specialskills, status)
    @team=team; @number=number; @name=name; @country=country; @position=position
    @talent=talent; @age=age; @level=level; @specialskills=specialskills; @status=status
    @goals_scored=0; @redcards=0; @yellowcards=0; @games=0; @goals_conceded=0; @play=true; @injure=0, @yel_cards=0
  end

  # Изменение возраста и уровня в большую сторону (при расчёте опыта после окончания сезона)
  def age_up
    @age+=1
    if @age==40
      
    end
    @age
  end
  def level_up
    if @talent<=3 || (@talent>3 && @specialskills.include?("+1опр"))
      @level+=@talent
    else
      @level+=@talent-1
    end
    @level
  end
  # Увеличение опыта из-за занятия им места в списке бомбардиров или другом рейтинге
  def level_plus(exp)
    @level+=exp
    @level
  end
  # Увеличение числа игр у игрока
  def games_plus(numb)
    @games+=numb
    @games
  end
  # Основной или резервный футболист
  def status
    if @status=="A" # Active, основной состав
      return "active"
    elsif @status=="R" # Reserve, запасной состав
      return "reserve"
    end
  end
  # Расчёт цены
  def price
    @price=(@talent*10000*@level/@age)
    if !@specialskills.nil? && @specialskills.size>=1
      @price+=25000*@specialskills.size
    end
    if @position.size>1
      @price+=100000
    end
    @price
  end
  # Специальные умения и добавление специальных умений
  def specialskills
    inp=@specialskills
    for i in 0...inp.size
      inp[i].chomp
      if inp[i]=="Ск" || inp[i]=="Шт" || inp[i]=="Тх" || inp[i]=="Ат" || inp[i]=="Пн" || inp[i]=="Од" || inp[i]=="Уд" #Скорость, Штрафные, Техника, Атлетизм, Пенальти, Один на один, Удар
        @level+=3
      elsif inp[i]=="Пд" || inp[i]=="Уг" || inp[i]=="Лд" || inp[i]=="Пл" #Подкат, Угловые, Лидер, Плеймейкер
        @level+=2
      elsif inp[i]=="Пр" || inp[i]=="Иг" || inp[i]=="Ов" || inp[i]=="Нв" || inp[i]=="Ун" #Перехват, Игра головой, От ворот, Навесы, Универсал
        @level+=1
      elsif inp[i]=="+1опр" # +1 очко при расчёте опыта
        @level
      end
    end
    @specialskills
  end
  def specialskills_plus(inp)
    @specialskills << inp
    @specialskills
  end
  # Добавление забитых голов (для полевых игроков) и вычитание пропущенных (для вратарей)
  def goals_scor
    @goals_scored
  end
  def goals_score(numb)
    @goals_scored+=numb
    @goals_scored
  end
  def goals_conced
    @goals_conceded
  end
  def goals_concede(numb)
    @goals_conceded-=numb
    @goals_conceded
  end
  # Добавление жёлтых и красных карточек
  def yellowcards(numb)
    @yellowcards+=numb
    if @yellowcards%4==0
      @play==false
    end
    @yellowcards
  end
  def redcards(numb)
    @redcards+=numb
    @play==false
    @redcards
  end
  # Желтые карточки в матче
  def yel_cards
    @yel_cards+=1
    @yel_cards
  end
  # Определение степени тяжести травмы игрока и вычитание пропущенных игр
  def injure(mat)
    @play=false
    @injure=mat
    @injure
  end
  def injure_minus
    @injure-=1
    if @injure==0
      @play=true
    end
    @injure
  end
  # Травмирован ли игрок?
  def injured?
    return @injure==0 ? false : true
  end
end

class Coach
  attr_reader :team, :name, :country, :style, :age, :experience, :price, :salary
  # Инициализация
  def initialize(team, name, country, style, talent, age, experience, salary)
    @team=team; @name=name; @country=country; @style=style
    @talent=talent; @age=age; @experience=experience; @salary=salary
  end
  # Цена
  def price
    @price = @experience*1000*@style.size/@age
  end
  # Зарплата тренера
  def salary
    @salary = @price/10.0
  end
  # Стили, которыми этот тренер владеет
  def style
    # Стили: АТ - атакующий, ОБ - оборонительный,  СВ - совмещённый, КТ - контратакующий, СЗЩ - суперзащитный, ПС - игра в пас
    
  end

end

class Stadium
  attr_reader :name, :holder, :volume
  def initialize(name, holder, volume)
    @name=name; @holder=holder; @volume=volume 
  end
  def volume_plus(numb)
    @volume+=numb
  end
end
