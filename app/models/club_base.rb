class ClubBase < ActiveRecord::Base
  belongs_to :team

  validates :team_id, presence: true
  validates :title, presence: true, uniqueness: true, length: {maximum: 30}
  validates :level, presence: true, inclusion: { in: 1..5 }
  validates :capacity, presence: true, inclusion: { in: [20,23,26,30,35]}
  validates :training_fields, presence: true, inclusion: { in: 1..5 }
  validates :experience_up, presence: true, inclusion: { in: [0.1,0.2,0.4,0.75,1.0] }
end
# level 2 --> capacity 20 \ COST: FREE \ experience_up 0.1 [default]
# level 2 --> capacity 23 \ COST: $50 000 \ experience_up 0.2
# level 3 --> capacity 26 \ COST: $200 000 \ experience_up 0.4
# level 4 --> capacity 30 \ COST: $1 000 000 \ experience_up 0.75
# level 5 --> capacity 35 \ COST: $2 500 000 \ experience_up 1.0