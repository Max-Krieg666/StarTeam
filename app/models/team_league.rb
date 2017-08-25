class TeamLeague < ActiveRecord::Base
  belongs_to :team
  belongs_to :league

  validates :team, uniqueness: { scope: :league }
end
