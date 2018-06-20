class Stadium < ActiveRecord::Base
  belongs_to :team, inverse_of: :stadium

  def to_param
    title
  end

  def self.find(input)
    input.length == 36 ? super : find_by_title(input)
  end

  def find_by_title(input)
    self.where(title: input).first
  end

  # левел => стоимость, min, max, seatcost
  LEVELS = {
    1 => [0,         0, 1000,   30],
    2 => [200000.0,  0, 5000,   50],
    3 => [500000.0,  0, 20000,  75],
    4 => [1000000.0, 0, 50000,  100],
    5 => [2500000.0, 0, 100000, 120]
  }

  validates :title, presence: true, uniqueness: true
  validates_format_of :title, with: /\A[-A-Za-z0-9_]+\z/, message: :incorrect
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :level, presence: true, inclusion: { in: 1..5 }

  def valid_capacity
    prs = LEVELS[level]
    "#{prs[1]} --- #{prs[2]}"
  end

  def next_level_cost
    LEVELS[level + 1][0]
  end

  def max_capacity
    LEVELS[level][2]
  end

  def seatcost
    LEVELS[level][3]
  end
end
# level 1 --> COST: FREE  ;  capacity 200-1 000 [default]
## seatcost: $30
# level 2 --> COST: $200 000  ;  capacity 1 001-5 000
## seatcost: $50
# level 3 --> COST: $500 000  ;  capacity 5 001-20 000
## seatcost: $75
# level 4 --> COST: $1 000 000  ;  capacity 20 001-50 000
## seatcost: $100
# level 5 --> COST: $2 500 000  ;  capacity 50 001-100 000
## seatcost: $120
