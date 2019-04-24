module Definer
  extend ActiveSupport::Concern

  DEFAULT_VALUES = {
    team_id: nil,
    state: :free_agent,
    status: :active,
    season_games: 0,
    season_goals: 0,
    season_passes: 0,
    season_conceded_goals: 0,
    season_autogoals: 0,
    season_yellow_cards: 0,
    season_red_cards: 0,
    can_play: true,
    games_missed: 0,
    captain: false,
    injured: false,
    morale: 5,
    physical_condition: 1.0,
    basic: false
  }.freeze

  def level_define
    case talent
    when 9
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
    when 8
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
    when 7
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
    when 6
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
    when 5
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
    when 3, 4
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
    when 2
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
    else # 1
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

  def need_training_points(level)
    if level.zero?
      15
    else # > 1
      50 * level * level
    end
  end

  def color_for_current_skill_level(lvl)
    case lvl
    when 200..300
      '#00ff17'
    when 150..200
      '#10a520'
    when 100..150
      '#0c7a17'
    when 75..100
      '#c5d500'
    when 45..75
      '#fffb00'
    when 30..45
      '#f58500'
    when 20..30
      '#fd9e01'
    else
      '#fd0101'
    end
  end
end
