# == Schema Information
#
# Table name: game_statistics
#
#  id                    :uuid             not null, primary key
#  game_id               :uuid
#  home_goals            :integer
#  home_shots            :integer          default(0)
#  home_shots_at_target  :integer          default(0)
#  home_corners          :integer          default(0)
#  home_fouls_committed  :integer          default(0)
#  home_yellow_cards     :integer          default(0)
#  home_red_cards        :integer          default(0)
#  home_offsides         :integer          default(0)
#  home_ball_possession  :integer          default(0)
#  guest_goals           :integer
#  guest_shots           :integer          default(0)
#  guest_shots_at_target :integer          default(0)
#  guest_corners         :integer          default(0)
#  guest_fouls_committed :integer          default(0)
#  guest_yellow_cards    :integer          default(0)
#  guest_red_cards       :integer          default(0)
#  guest_offsides        :integer          default(0)
#  guest_ball_possession :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class GameStatistic < ApplicationRecord
  belongs_to :game

  def result
    "#{home.title} - #{guest.title} #{simple_result_home}"
  end

  def simple_result_home
    return '-:-' unless home_goals
    "#{home_goals}:#{guest_goals}"
  end

  def simple_result_guest
    return '-:-' unless guest_goals
    "#{guest_goals}:#{home_goals}"
  end
end
