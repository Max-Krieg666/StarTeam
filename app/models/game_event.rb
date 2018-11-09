class GameEvent < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

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
    # гол с рикошетом от защитника
    goal_by_rebound:       13,
    # гол с отскоком от вратаря
    goal_by_rebound_gk:    14,
    # гол после добивания
    goal_after_2nd_kick:   15,
    # автогол
    auto_goal:             20,

    # события, связанные с пенальти
    # пенальти назначен
    penalty_kick:                   60,
    # пенальти не реализован (общее)
    penalty_not_realize:            61,
    # вратарь отбил в поле на своего
    penalty_save_to_own_player:     62,
    # вратарь отбил в поле на чужого
    penalty_save_to_strange_player: 63,
    # вратарь взял мяч, прижав
    penalty_saved:                  64,
    # игрок пробил мимо ворот
    penalty_shoot_out:              65,
    # игрок пробил в штангу
    penalty_post:                   66

    # TODO: add here next kinds
    # (по сути по 1 типу на каждое событие в tmatch_start.rb)
    #
    # passes
    # kicks (freekick)
    # 
    # cards =>>> yellowcard double_yellowcard redcard
    # injuries =>>> player_on player_off
  }

  def kind_full_title
    # TODO: add here all translates (ru & en)
    I18n.t("game_events.#{kind}", name: player.name)
  end
end
