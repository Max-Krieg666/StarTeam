class Stadium < ActiveRecord::Base
  belongs_to :team

  validates :team_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :capacity, presence: true, numericality: {
    greater_than_or_equal_to: 0, only_integer: true}
  validates :level, presence: true, inclusion: { in: 1..5 }
end
# level 1 --> COST: FREE  ;  capacity 200-1 000 [default]
## seatcost: $500
# level 2 --> COST: $200 000  ;  capacity 1 001-5 000
## seatcost: $400
# level 3 --> COST: $500 000  ;  capacity 5 001-20 000
## seatcost: $300
# level 4 --> COST: $1 000 000  ;  capacity 20 001-50 000
## seatcost: $200
# level 5 --> COST: $2 500 000  ;  capacity 50 001>
## seatcost: $100