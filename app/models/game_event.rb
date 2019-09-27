# == Schema Information
#
# Table name: game_events
#
#  id        :uuid             not null, primary key
#  game_id   :uuid
#  player_id :uuid
#  team_id   :uuid
#  kind      :integer
#  minute    :string
#

class GameEvent < ApplicationRecord
  # TODO: add danger_rating (рейтинг опасности события)
  # 0 - neutra (дефолтныйl)
  # 1 - light
  # 2 - medium
  # 3 - high
  # 4 - extreme

  # TODO-2: add rare_point (редкость события)
  # 0 - very_often
  # 1 - often
  # 2 - mid (дефолтныйl)
  # 3 - rare
  # 4 - very_rare
  # 5 - extreme_rare

  belongs_to :game
  belongs_to :team, optional: true
  belongs_to :attacker_player, class_name: 'Player', optional: true
  belongs_to :defender_player, class_name: 'Player', optional: true

  enum kind: {
    # события, связанные с голами
    # гол
    goal:                  1,
    # гол с пенальти
    goal_pen:              2,
    # гол от штанги
    goal_by_post:          3,
    # гол от перекладины
    goal_by_crossbar:      4,
    # гол ударом головой
    goal_by_head:          5,
    # гол ударом головой в прыжке
    goal_by_head_jumping:  6,
    # гол ударом ноги
    goal_by_leg:           7,
    # гол ударом с лёта
    goal_by_flying_kick:   8,
    # гол ножницами
    goal_by_scissors_kick: 9,
    # гол в дальний угол
    goal_to_far_corner:    10,
    # гол в ближний угол
    goal_to_near_corner:   11,
    # гол в девятку
    goal_to_9_point_zone:  12,
    # гол в нижний угол
    goal_to_lower_corner:  13,
    # гол с рикошетом от защитника
    goal_by_rebound:       14,
    # гол с отскоком от вратаря
    goal_by_rebound_gk:    15,
    # гол после добивания
    goal_after_2nd_kick:   16,
    # гол в пустые ворота
    goal_into_empty_gates: 17,
    # автогол защитника
    own_goal_by_defender:  30,
    # автогол после ошибки вратаря
    own_goal_by_gk:        31,

    # события, связанные с пенальти (удары)
    # пенальти назначен
    penalty_kick:                   60,
    # пенальти не реализован (общее)
    penalty_not_realize:            61,
    # вратарь отбил мяч в поле на своего
    penalty_save_to_own_player:     62,
    # вратарь отбил мяч в поле на чужого
    penalty_save_to_strange_player: 63,
    # вратарь взял мяч, зафиксировав его
    penalty_saved:                  64,
    # игрок пробил мимо ворот
    penalty_shoot_out:              65,
    # игрок пробил выше ворот
    penalty_shoot_out_up:           66,
    # игрок пробил в штангу
    penalty_post:                   67,
    # игрок пробил в перекладину
    penalty_crossbar:               68,

    # события, связанные со штрафными (удары/розыгрыши)
    # назначен штрафной
    free_kick:                           80,
    # удар со штрафного не точен (общее)
    free_kick_not_realize:               81,
    # вратарь отбил мяч в поле на своего
    free_kick_save_to_own_player:        82,
    # вратарь отбил мяч в поле на чужого
    free_kick_save_to_strange_player:    83,
    # вратарь взял мяч, зафиксировав его
    free_kick_saved:                     84,
    # игрок пробил мимо ворот
    free_kick_shoot_out:                 85,
    # игрок пробил выше ворот
    free_kick_shoot_out_up:              86,
    # игрок пробил в штангу
    free_kick_post:                      87,
    # игрок пробил в перекладину
    free_kick_crossbar:                  88,
    # игрок пробил в стенку
    free_kick_shoot_the_wall:            89,
    # игрок пробил в стенку и мяч ушел на угловой
    free_kick_shoot_the_wall_and_corner: 90,
    # игрок пробил над стенкой
    free_kick_over_the_wall:             91,
    # навес в штрафную
    free_kick_long_pass_in_pen_area:     92,
    # навес (обычный, на своего)
    free_kick_long_pass_correct:         93,
    # навес (неудачный)
    free_kick_long_pass_unsuccess:       94,
    # пас ближе к штрафной на своего
    free_kick_short_pass_correct:        95,
    # пас (неудачный)
    free_kick_short_pass_unsuccess:      96,
    # пас на фланг
    free_kick_pass_to_flank:             97,
    # розыгрыш штрафного
    free_kick_ball_kick:                 98,

    # события, связанные с угловыми (удары/навесы/розыгрыши)
    # назначен угловой (общее)
    corner:                           110,
    # назначен угловой (от ноги соперника)
    corner_cause_of_leg:              111,
    # назначен угловой (из-за прессинга соперника)
    corner_cause_of_pressure:         112,
    # назначен угловой (соперник выбил)
    corner_cause_of_shoot_out:        113,
    # назначен угловой (от головы соперника)
    corner_cause_of_head:             114,
    # неточный прямой удар с углового (! - экстремально редкий)
    corner_direct_shoot_unaccurate:   115,
    # точный прямой удар с углового (! - экстремально редкий)
    corner_direct_shoot_accurate:     116,
    # неточный навес в штрафную (общее)
    corner_long_pass_unaccurate:      117,
    # точный навес в штрафную (общее)
    corner_long_pass_correct:         118,
    # розыгрыш с ближним
    corner_short_pass:                119,
    # навес на ближнюю штангу
    corner_pass_to_near_post:         120,
    # навес на дальнюю штангу
    corner_pass_to_far_post:          121,
    # сильный прострел в штрафную (! - редкий)
    corner_power_pass_to_pen_area:    122,
    # навес в центр
    corner_pass_to_center:            123,

    # события, связанные с развитием атаки
    # пас в центре поля
    pass_at_the_center:                 140,
    # перепасовка в центре поля
    passes_at_the_center:               141,
    # игрок начинает атаку
    player_is_starting_an_attack:       142,
    # игрок пытается прорваться по флангу
    player_is_trying_to_break_to_flank: 143,
    # дальний пас на форварда
    long_pass_to_forward:               144,
    # дальний пас на правый фланг
    long_pass_to_right_flank:           145,
    # дальний пас на левый фланг
    long_pass_to_left_flank:            146,
    # пас на правый фланг
    pass_to_right_flank:                147,
    # пас на левый фланг
    pass_to_left_flank:                 148,

    # события, связанные с защитой
    # неудачный перехват
    intercept_unsuccessful:             170,
    # успешный перехват
    intercept_successful:               171,
    # низкий прессинг
    pressure_low:                       172,
    # высокий прессинг
    pressure_high:                      173,
    # чистый отбор (общее)
    tackling_clean:                     174,
    # грубый отбор (нет фола)
    tackling_rude_no_foul:              175,
    # грубый отбор (фол)
    tackling_rude_with_foul:            176,
    # чистый подкат (общее)
    tackle_clean:                       177,
    # чистый подкат с боку
    tackle_clean_side:                  178,
    # подкат с боку (фол)
    tackle_dirty_with_foul:             179,
    # подкат сзади (фол)
    back_tackle_dirty_with_foul:        180,
    # подкат прямой ногой (фол)
    tackle_rude_straight_leg:           181,
    # игра в корпус
    body_tackling:                      182,
    # мелкое нарушение (общее)
    light_foul:                         183,

    # общие фразы / common phrases
    # что решит арбитр?
    what_decide_a_referee:              300,
    # игра успокоилась
    the_game_calm_down:                 301,
    # фанаты довольны игрой
    fanats_are_happy:                   302,
    # фанаты в бешенстве
    fanats_goes_crazy:                  303,
    # фанаты в ярости
    fanats_in_rage:                     304,
    # могут начаться беспорядки на трибунах
    riots_may_begins_at_stands:         305,
    # идёт просмотр эпизода VAR
    var_in_game:                        306,
    # Тренер нервно ходит по бровке
    coach_is_going_nervous:             307,
    # Тренер недоволен происходящим
    coach_dissatisfied:                 308,
    # Тренер дал записку одному из игроков
    coach_give_a_message:               309,
    # Тренер в ярости
    coach_in_rage:                      310,
    # Несколько игроков отправились разминаться
    some_players_warm_up:               311,

    # TODO: add here next kinds
    # (по сути по 1 типу на каждое событие в tmatch_start.rb)
    # cards =>>> yellowcard double_yellowcard redcard
    # injuries =>>> player_on player_off
  }

  def kind_full_title
    # TODO: add here all translates (ru & en)
    I18n.t("game_events.#{kind}", name: player.name)
  end
end
