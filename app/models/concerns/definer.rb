module Definer
  extend ActiveSupport::Concern

  @@posit = %w(Gk Ld Cd Rd Cdm Lm Cm Rm Cam Lf Cf Rf)

  def state_in_human(state)
    case state
      when 0
        'свободен'
      when 1
        'в команде'
      else #2
        'завершил карьеру'
    end
  end

  def right_alph_srt(pos)
    case pos
      when 'Gk'
        1
      when 'Ld'
        2
      when 'Cd'
        3
      when 'Rd'
        4
      when 'Lm'
        5
      when 'Cdm'
        6
      when 'Cm'
        7
      when 'Cam'
        8
      when 'Rm'
        9
      when 'Lf'
        10
      when 'Cf'
        11
      else# 'Rf'
        12
    end
  end

  def level_define
    if talent==9
      if skill_level>100
        age<33 ? a=10 : a=9
      elsif skill_level>50
        a=8 if age>35
        a=9 if age>25 && age<36
        a=10 if age<26
      else
        a=6 if age>35
        a=7 if age>25 && age<36
        a=8 if age<26
      end
    elsif talent==8
      if skill_level>100
        age<33 ? a=9 : a=8
      elsif skill_level>50
        a=7 if age>25
        a=8 if age<26
      else
        a=5 if age>35
        a=6 if age>25 && age<36
        a=7 if age<26
      end
    elsif talent==7
      if skill_level>100
        age<33 ? a=9 : a=7
      elsif skill_level>50
        a=6 if age>35
        a=7 if age>25 && age<36
        a=8 if age<26
      else
        a=5 if age>35
        a=6 if age>25 && age<36
        a=7 if age<26
      end
    elsif talent==6
      if skill_level>100
        age<33 ? a=7 : a=5
      elsif skill_level>50
        a=6 if age>35
        a=7 if age>25 && age<36
        a=8 if age<26
      else
        a=4 if age>35
        a=5 if age>25 && age<36
        a=7 if age<26
      end
    elsif talent==5
      if skill_level>100
        a=7 if age<26
        a=6 if age>25 && age<33
        a=5 if age>32
      elsif skill_level>50
        a=5 if age>35
        a=6 if age>25 && age<36
        a=7 if age<26
      else
        a=4 if age>35
        a=5 if age>25 && age<36
        a=7 if age<26
      end
    elsif talent==4 || talent==3
      if skill_level>100
        age<33 ? a=6 : a=5
      elsif skill_level>50
        a=4 if age>35
        a=5 if age>25 && age<36
        a=6 if age<26
      else
        a=3 if age>35
        a=4 if age>25 && age<36
        a=5 if age<26
      end
    elsif talent==2
      if skill_level>100
        age<33 ? a=4 : a=3
      elsif skill_level>50
        a=2 if age>35
        a=3 if age>25 && age<36
        a=4 if age<26
      else
        a=1 if age>35
        a=2 if age>25 && age<36
        a=3 if age<26
      end
    else #talent==1
      if skill_level>100
        age<33 ? a=3 : a=2
      elsif skill_level>50
        a=1 if age>35
        a=2 if age>25 && age<36
        a=3 if age<26
      else
        age>25 ? a=1 : a=2
      end
    end
    a
  end
end