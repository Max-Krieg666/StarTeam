class Sponsor < ActiveRecord::Base
  belongs_to :team

  validates :title, presence: true, uniqueness: true, length:{maximum: 30}
  validates :specialization, presence: true, length: {maximum: 100}
  #validates :sponsorship, uniqueness: true, presence: true
  validates :loyalty_factor, presence: true, numericality: {greater_than: -2.0}
  validates :cost_of_full_stake, presence: true
  validates :win_prize, presence: true, numericality: {greater_than: 100.0}
  validates :draw_prize, presence: true, numericality: {greater_than: 100.0}
  validates :lost_prize, presence: true, numericality: {greater_than: 100.0}
end