# == Schema Information
#
# Table name: game_players
#
#  id              :uuid             not null, primary key
#  game_id         :uuid
#  player_id       :uuid
#  goals           :integer          default(0)
#  shots           :integer          default(0)
#  shots_at_target :integer          default(0)
#  fouls_committed :integer          default(0)
#  yellow_cards    :integer          default(0)
#  red_cards       :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :player
end
