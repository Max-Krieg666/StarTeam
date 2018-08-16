class Stadium < ActiveRecord::Base
  DEFAULT_LEVEL = 5
  MAX_CAPACITY = 100_000

  belongs_to :team, inverse_of: :stadium

  def to_param
    title.tr(' ', '+')
  end

  def self.find(input)
    return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
    find_by_title(input.tr('+', ' '))
  end

  def find_by_title(input)
    find_by title: input
  end

  # левел => стоимость, min, max, seatcost
  LEVELS = {
    1 => [0,           0, 1_000,   30],
    2 => [200_000.0,   0, 5_000,   50],
    3 => [500_000.0,   0, 20_000,  75],
    4 => [1_000_000.0, 0, 50_000,  100],
    5 => [2_500_000.0, 0, 100_000, 120]
  }.freeze

  validates :title, presence: true, uniqueness: true
  validates_format_of :title, with: /\A[-A-Za-z0-9_ ]+\z/, message: :incorrect
  validates :capacity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, only_integer: true }
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

  def max_capacity?
    capacity == MAX_CAPACITY && max_level?
  end

  def max_level?
    level == DEFAULT_LEVEL
  end

  def low_capacity?(value)
    capacity > value
  end

  def low_level?(value)
    max_capacity < value
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
