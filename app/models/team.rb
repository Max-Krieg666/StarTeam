class Team < ActiveRecord::Base
  belongs_to :user
  has_one :sponsor
  has_one :stadium
  has_one :club_basis
  has_many :players
  has_many :transfers

  validates :title, presence: true, uniqueness: true, length: {maximum: 50}
  validates :sponsor_id, presence: true
  validates :budget, presence: true
  validates :fans, presence: true
end
