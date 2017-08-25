class TeamCup < ActiveRecord::Base
  belongs_to :team
  belongs_to :cup

  validates :team, uniqueness: { scope: :cup }
end
