class Team < ActiveRecord::Base
  belongs_to :user
  has_one :sponsor
  has_one :stadium
  has_one :club_basis

  validates :title, presence: true, uniqueness: true, length: {maximum: 50}
  validates :sponsor, presence: true
  validates :budget, presence: true
  validates :fans, presence: true
end
