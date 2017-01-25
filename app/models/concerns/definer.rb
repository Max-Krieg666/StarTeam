module Definer
  extend ActiveSupport::Concern

  def level_define
    if talent == 9
      if skill_level > 100
        a = (age < 33 ? 10 : 9)
      elsif skill_level > 50
        a = 8 if age > 35
        a = 9 if age > 25 && age < 36
        a = 10 if age < 26
      else
        a = 6 if age > 35
        a = 7 if age > 25 && age < 36
        a = 8 if age < 26
      end
    elsif talent == 8
      if skill_level > 100
        a = (age < 33 ? 9 : 8)
      elsif skill_level > 50
        a = 7 if age > 25
        a = 8 if age < 26
      else
        a = 5 if age > 35
        a = 6 if age > 25 && age < 36
        a = 7 if age < 26
      end
    elsif talent == 7
      if skill_level > 100
        a = (age < 33 ? 9 : 7)
      elsif skill_level > 50
        a = 6 if age > 35
        a = 7 if age > 25 && age < 36
        a = 8 if age < 26
      else
        a = 5 if age > 35
        a = 6 if age > 25 && age < 36
        a = 7 if age < 26
      end
    elsif talent == 6
      if skill_level > 100
        a = (age < 33 ? 7 : 5)
      elsif skill_level > 50
        a = 6 if age > 35
        a = 7 if age > 25 && age < 36
        a = 8 if age < 26
      else
        a = 4 if age > 35
        a = 5 if age > 25 && age < 36
        a = 7 if age < 26
      end
    elsif talent == 5
      if skill_level > 100
        a = 7 if age < 26
        a = 6 if age > 25 && age < 33
        a = 5 if age > 32
      elsif skill_level > 50
        a = 5 if age > 35
        a = 6 if age > 25 && age < 36
        a = 7 if age < 26
      else
        a = 4 if age > 35
        a = 5 if age > 25 && age < 36
        a = 7 if age < 26
      end
    elsif talent == 4 || talent == 3
      if skill_level > 100
        a = (age < 33 ? 6 : 5)
      elsif skill_level > 50
        a = 4 if age > 35
        a = 5 if age > 25 && age < 36
        a = 6 if age < 26
      else
        a = 3 if age > 35
        a = 4 if age > 25 && age < 36
        a = 5 if age < 26
      end
    elsif talent == 2
      if skill_level > 100
        a = (age < 33 ? 4 : 3)
      elsif skill_level > 50
        a = 2 if age > 35
        a = 3 if age > 25 && age < 36
        a = 4 if age < 26
      else
        a = 1 if age > 35
        a = 2 if age > 25 && age < 36
        a = 3 if age < 26
      end
    else # talent == 1
      if skill_level > 100
        a = (age < 33 ? 3 : 2)
      elsif skill_level > 50
        a = 1 if age > 35
        a = 2 if age > 25 && age < 36
        a = 3 if age < 26
      else
        a = (age > 25 ? 1 : 2)
      end
    end
    a
  end

  def self.need_points(level)
    if level.zero?
      15
    else # > 1
      50 * level * level
    end
  end
end
