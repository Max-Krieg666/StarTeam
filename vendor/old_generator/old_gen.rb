#encoding:UTF-8
def randomize()
  n=1
  2.times do
    i=rand(10370)
    puts
    print "Случайная выборка #{n} -> #{i}"
    puts
    if (i>=0) && (i<=5)
      x=12
    elsif (i>5) && (i<=19)
      x=11
    elsif (i>19) && (i<=44)
      x=10
    elsif (i>44) && (i<=80)
      x=9
    elsif (i>80) && (i<=132)
      x=8
    elsif (i>132) && (i<=229)
      x=7
    elsif (i>229) && (i<=386)
      x=6
    elsif (i>386) && (i<=655)
      x=5
    elsif (i>655) && (i<=1213)
      x=4
    elsif (i>1213) && (i<=2303)
      x=3
    elsif (i>2303) && (i<=4099)
      x=2
    elsif (i>4099) && (i<=7056)
      x=1
    elsif (i>7056) && (i<=10369)
      x=0
    end
    if x==0 || x==5 || x==6 || x==7 || x==8 || x==9 || x==10 || x==11 || x==12
      puts "Команда #{n} забила -> #{x} голов"
    elsif x==1
      puts "Команда #{n} забила -> #{x} гол"
    else
      puts "Команда #{n} забила -> #{x} гола"
    end
    n+=1
    step=0
    while step!=x
      puts "Забил игрок под номером #{rand(99)+1}"
      step+=1
      sleep 0.5
    end
  end
end
5.times do
puts randomize()
puts 
end