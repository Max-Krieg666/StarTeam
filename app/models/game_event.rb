# == Schema Information
#
# Table name: game_events
#
#  id        :uuid             not null, primary key
#  game_id   :uuid
#  player_id :uuid
#  kind      :integer
#  minute    :string
#

class GameEvent < ApplicationRecord
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
    auto_goal_by_defender: 30,
    # автогол после ошибки вратаря
    auto_goal_by_gk:       31,

    # события, связанные с пенальти
    # пенальти назначен
    penalty_kick:                   60,
    # пенальти не реализован (общее)
    penalty_not_realize:            61,
    # вратарь отбил мяч в поле на своего
    penalty_save_to_own_player:     62,
    # вратарь отбил мяч в поле на чужого
    penalty_save_to_strange_player: 63,
    # вратарь взял мяч, прижав
    penalty_saved:                  64,
    # игрок пробил мимо ворот
    penalty_shoot_out:              65,
    # игрок пробил в штангу
    penalty_post:                   66,

    # события, связанные с развитием атаки
    # пас в центре поля
    pass_at_the_center:                 80,
    # перепасовка в центре поля
    passes_at_the_center:               81,
    # игрок начинает атаку
    player_is_starting_an_attack:       82,
    # игрок пытается прорваться по флангу
    player_is_trying_to_break_to_flank: 83

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
