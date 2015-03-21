class ClubBase < ActiveRecord::Base

  validates :owner, uniqueness: true, presence: true
  validates :title, presence: true, uniqueness: true, length: {maximum: 30}
  validates :level, presence: true
  validates :capacity, presence: true
  validates :training_fields, presence: true
  validates :experience_up, presence: true
end
