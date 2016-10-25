class PlayerGenerator
  POS = %w(Gk Ld Cd Rd Lm Cm Rm Lf Cf Rf Cm Cd Cm Cf).freeze

  def initialize(count, x = nil)
    ActiveRecord::Base.transaction do
    	count.times do |i|
        x = rand(252) if x.nil?
        pl = Player.new
        ts = POS[rand(POS.size)]
        raise ts if ts==0
        pl.position1 = ts
        pl.position2 = ''
        pl.state = 0
        pl.basic = false
        pl.talent = (
          case rand(700) + 1
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
          end
        )
        pl.age = (
          case rand(1000) + 1
          when 0..88
            pl.talent >= 7 ? 25 : (pl.talent < 3 ? 31 : 29)
          when 89..168
            pl.talent >= 7 ? 24 : (pl.talent < 3 ? 30 : 28)
          when 169..258
            pl.talent >= 7 ? 23 : (pl.talent < 3 ? 27 : 36)
          when 259..347
            pl.talent >= 7 ? 22 : (pl.talent < 3 ? 35 : 33)
          when 348..479
            pl.talent >= 7 ? 21 : (pl.talent < 3 ? 34 : 38)
          when 480..545
            pl.talent >= 7 ? 20 : (pl.talent < 3 ? 37 : 32)
          when 546..611
            pl.talent >= 7 ? 19 : (pl.talent < 3 ? 26 : 22)
          when 612..666
            pl.talent >= 7 ? 18 : (pl.talent < 3 ? 31 : 20)
          when 667..800
            pl.talent >= 7 ? 28 : (pl.talent < 3 ? 33 : 35)
          when 801..877
            pl.talent >= 7 ? 26 : (pl.talent < 3 ? 30 : 23)
          when 878..950
            pl.talent >= 7 ? 27 : (pl.talent < 3 ? 29 : 30)
          else
            pl.talent >= 7 ? 17 : (pl.talent < 3 ? 27 : 18)
          end
        )
        pl.skill_level = (
          case rand(400) + 1
          when 0..88
            pl.talent > 5 ? rand(45..63) : rand(25..44)
          when 89..168
            pl.talent > 5 ? rand(40..60) : rand(29..39)
          when 169..258
            rand(40..74)
          when 259..347
            pl.talent > 5 ? rand(50..57) : rand(37..49)
          when 348..350
            rand(70..125)
          else
            rand(25..74)
          end
        )
        pl.price = (pl.talent * pl.skill_level * 10000 / pl.age).round(3)
        pl.name = Name.new(x).rand_name
        pl.country_id = x
        pl.save!
        # puts "#{i + 1}: " + pl.name + " <#{x}>"
      end
      puts "#{count} players_create: OK!"
    end
  rescue Exception => ex
    puts ex.message
  end
end
