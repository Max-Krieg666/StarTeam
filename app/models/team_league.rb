# == Schema Information
#
# Table name: team_leagues
#
#  id             :uuid             not null, primary key
#  team_id        :uuid
#  league_id      :uuid
#  division       :integer
#  place          :integer
#  tour           :integer
#  games          :integer          default(0)
#  goals          :integer          default(0)
#  goals_conceded :integer          default(0)
#  wins           :integer          default(0)
#  draws          :integer          default(0)
#  loses          :integer          default(0)
#  points         :integer          default(0)
#

class TeamLeague < ApplicationRecord
  belongs_to :team
  belongs_to :league

  validates :team, uniqueness: { scope: :league }

  def goals_readable
    [goals, goals_conceded].join('-')
  end

  def goals_difference
    goals - goals_conceded
  end
end
