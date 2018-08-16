class GameEvent < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  enum kind: %i[
    nothing
    goal goal_pen_realize goal_pen_not_realize
    yellowcard doubleyellowcard redcard
    injury
    on off
  ]
end
