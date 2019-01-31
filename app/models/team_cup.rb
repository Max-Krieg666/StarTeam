# == Schema Information
#
# Table name: team_cups
#
#  id             :uuid             not null, primary key
#  team_id        :uuid
#  cup_id         :uuid
#  division       :integer
#  stage          :integer
#  games          :integer          default(0)
#  goals          :integer          default(0)
#  goals_conceded :integer          default(0)
#

class TeamCup < ApplicationRecord
  belongs_to :team
  belongs_to :cup

  validates :team, uniqueness: { scope: :cup }
end
