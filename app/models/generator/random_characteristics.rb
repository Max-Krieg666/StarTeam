module Generator
  class RandomCharacteristics
    attr_reader :player, :skill_level, :current_skills, :position,
                :force_defend, :force_attack,
                :force_physics, :force_mental,
                :defend, :attack, :physics, :mental

    def initialize(player)
      @player = player
      @skill_level = @player.skill_level
      @current_skills = 0
      @position = @player.position1
      # tackling, marking, positioning, heading, pressure
      @defend = [0, 0, 0, 0, 0]
      # shot_accuracy, shot_power, dribbling, passing, carport
      @attack = [0, 0, 0, 0, 0]
      # speed, endurance, reaction
      @physics = [0, 0, 0]
      # aggression, creativity
      @mental = [0, 0]
      define_forces
    end

    def randomize
      # рандом значений
      rand_defend_forces
      rand_attack_forces
      rand_physics_forces
      rand_mental_forces
      # применение
      player.tackling = defend[0]
      player.marking = defend[1]
      player.positioning = defend[2]
      player.heading = defend[3]
      player.pressure = defend[4]
      player.shot_accuracy = attack[0]
      player.shot_power = attack[1]
      player.dribbling = attack[2]
      player.passing = attack[3]
      player.carport = attack[4]
      player.speed = physics[0]
      player.endurance = physics[1]
      player.reaction = physics[2]
      player.aggression = mental[0]
      player.creativity = mental[1]
      player
    end

    private

    def define_forces
      # force_& - это показатель развитости хар-к на той или иной позиции
      case position
      when 0 # Gk
        @force_defend = 30
        @force_attack = 25
        @force_physics = 35
        @force_mental = 10
      when 1, 2, 3 # Ld, Cd, Rd
        @force_defend = 45
        @force_attack = 20
        @force_physics = 20
        @force_mental = 15
      when 4, 5, 6 # Lm, Cm, Rm
        @force_defend = 25
        @force_attack = 25
        @force_physics = 25
        @force_mental = 25
      else # 7, 8, 9 (Lf, Cf, Rf)
        @force_defend = 20
        @force_attack = 50
        @force_physics = 20
        @force_mental = 10
      end
    end

    def rand_defend_forces
      defend_points = skill_level * force_defend / 100
      defend_points.times do
        defend[rand(5)] += 1
      end
      @current_skills += defend_points
    end

    def rand_attack_forces
      attack_points = skill_level * force_attack / 100
      attack_points.times do
        attack[rand(5)] += 1
      end
      @current_skills += attack_points
    end

    def rand_physics_forces
      physics_points = skill_level * force_physics / 100
      physics_points.times do
        physics[rand(3)] += 1
      end
      @current_skills += physics_points
    end

    def rand_mental_forces
      mental_points = skill_level * force_mental / 100
      mental_points.times do
        mental[rand(2)] += 1
      end
      @current_skills += mental_points
      return if @current_skills == @skill_level

      (skill_level - current_skills).times do
        mental[rand(2)] += 1
      end
    end
  end
end
