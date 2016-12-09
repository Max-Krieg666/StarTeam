class PlayerGenerator
  POS = %w(Gk Ld Cd Rd Lm Cm Rm Lf Cf Rf Cm Cd Cm Cf).freeze

  def initialize(count, x = nil, pos = nil, state = 0)
    ActiveRecord::Base.transaction do
      count.times do |i|
        x = rand(252) if x.nil?
        pl = Player.new
        pl.position1 = pos || POS[rand(POS.size)]
        pl.position2 = ''
        pl.state = state
        pl.basic = false
        pl.talent = self.rand_talent
        pl.age = self.rand_age(pl.talent)
        pl.skill_level = self.rand_skill_level(pl.talent)
        pl.name = Name.new(x).rand_name
        pl.country_id = x
        pl.save!
      end
      puts "#{count} players_create: OK!"
    end
  rescue Exception => ex
    puts ex.message
  end

  def self.rand_talent
    case SecureRandom.random_number(700)
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
    when 480..548
      6
    when 549..612
      7
    when 613..666
      8
    else
      9
    end
  end

  def self.rand_age(talent)
    case SecureRandom.random_number(1000)
    when 0..88
      talent >= 7 ? 25 : (talent < 3 ? 31 : 29)
    when 89..168
      talent >= 7 ? 24 : (talent < 3 ? 30 : 28)
    when 169..258
      talent >= 7 ? 23 : (talent < 3 ? 27 : 36)
    when 259..347
      talent >= 7 ? 22 : (talent < 3 ? 35 : 33)
    when 348..479
      talent >= 7 ? 21 : (talent < 3 ? 34 : 38)
    when 480..545
      talent >= 7 ? 20 : (talent < 3 ? 37 : 32)
    when 546..611
      talent >= 7 ? 19 : (talent < 3 ? 26 : 22)
    when 612..666
      talent >= 7 ? 18 : (talent < 3 ? 31 : 20)
    when 667..800
      talent >= 7 ? 28 : (talent < 3 ? 33 : 35)
    when 801..877
      talent >= 7 ? 26 : (talent < 3 ? 30 : 23)
    when 878..950
      talent >= 7 ? 27 : (talent < 3 ? 29 : 30)
    else
      talent >= 7 ? 17 : (talent < 3 ? 27 : 18)
    end
  end

  def self.rand_skill_level(talent)
    case SecureRandom.random_number(400)
    when 0..88
      talent > 5 ? rand(45..63) : rand(25..44)
    when 89..168
      talent > 5 ? rand(40..60) : rand(29..39)
    when 169..258
      rand(40..74)
    when 259..340
      talent > 5 ? rand(50..57) : rand(37..49)
    when 341..350
      rand(70..125)
    else
      rand(25..74)
    end
  end

  def self.rand_number(presence_numbers)
    num = rand(99) + 1
    num = rand(99) + 1 while presence_numbers.include?(num)
    num
  end
end
