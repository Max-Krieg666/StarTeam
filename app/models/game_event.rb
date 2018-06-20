class GameEvent < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  enum kind: [
    :goal, :goal_pen, :not_goal_pen,
    :yellowcard, :doubleyellowcard, :redcard,
    :injury, :on, :off
  ]
end