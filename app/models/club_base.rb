class ClubBase < ActiveRecord::Base
  belongs_to :team

  LEVELS = {
    1 => [50000.0, 0.2, 22],
    2 => [400000.0, 0.2, 24],
    3 => [1000000.0, 0.35, 26],
    4 => [2500000.0, 0.25, 30]
  }

  TRAINING_FIELDS = {
    1 => [250000.0, 0.2],
    2 => [750000.0, 0.2],
    3 => [1500000.0, 0.35],
    4 => [3500000.0, 0.25]
  }

  validates :title, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :level, presence: true, inclusion: { in: 1..5 }
  validates :capacity, presence: true, inclusion: { in: [20, 22, 24, 26, 30] }
  validates :training_fields, presence: true, inclusion: { in: 1..5 }
  validates :experience_up, presence: true, inclusion: { in: 0.1..2.0 }
end
# level 1 --> capacity 20 \ COST: FREE \ experience_up 0.0 [default]
# level 2 --> capacity 23 \ COST: $50 000 \ experience_up 0.2
# level 3 --> capacity 26 \ COST: $400 000 \ experience_up 0.4
# level 4 --> capacity 30 \ COST: $1 000 000 \ experience_up 0.75
# level 5 --> capacity 35 \ COST: $2 500 000 \ experience_up 1.0

# training_fields 1 --> experience_up 0.0 \ COST: FREE \ [default]
# training_fields 2 --> experience_up 0.2 \ COST: $250 000
# training_fields 3 --> experience_up 0.5 \ COST: $750 000
# training_fields 4 --> experience_up 0.75 \ COST: $1 500 000
# training_fields 5 --> experience_up 1.0 \ COST: $3 000 000