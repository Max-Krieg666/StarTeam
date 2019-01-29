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
