class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_one :sponsor
  has_one :stadium
  has_one :club_base
  has_many :players
  has_many :transfers

  validates :title, presence: true, uniqueness: true, length: { maximum: 24 }
  validates :budget, presence: true
  validates :fans, presence: true

  def captain
    players.order('price desc').limit(1).first
  end

  def squad_size
    players.size
  end
end
