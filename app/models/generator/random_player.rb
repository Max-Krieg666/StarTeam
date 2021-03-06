module Generator
  class RandomPlayer
    POS = %w[Gk Ld Cd Rd Lm Cm Rm Lf Cf Rf].freeze

    def initialize(count, country_id = nil, pos = nil, state = 0)
      ActiveRecord::Base.transaction do
        count.times do
          country_id = SecureRandom.random_number(252) if country_id.nil?
          pl = Player.new
          pl.position1 = pos || SecureRandom.random_number(POS.size)
          pl.state = state
          pl.basic = false
          pl.talent = rand_talent
          pl.age = rand_age(pl.talent)
          pl.skill_level = rand_skill_level(pl.talent)
          pl.name = Generator::RandomName.new(country_id).rand_name
          pl.country_id = country_id
          Generator::RandomCharacteristics.new(pl).randomize.save!
        end
      end
    rescue => e
      puts "FAILURE WITH ->>>> #{e.message}"
    end

    class << self
      def rand_talent
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

      def rand_age(talent)
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

      def rand_skill_level(talent)
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

      def rand_number
        Faker::Number.unique.between(from: 1, to: 100)
      end
    end
  end
end
