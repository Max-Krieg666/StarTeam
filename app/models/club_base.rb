class ClubBase < ActiveRecord::Base
  belongs_to :team

  def to_param
    title.gsub(' ', '-')
  end

  def self.find(input)
    input.length == 36 ? super : find_by_title(input)
  end

  def find_by_title(input)
    self.where(title: input).first
  end

  LEVELS = {
    1 => [0,         0,    20],
    2 => [50000.0,   0.2,  22],
    3 => [400000.0,  0.2,  24],
    4 => [1000000.0, 0.35, 26],
    5 => [2500000.0, 0.25, 30]
  }

  TRAINING_FIELDS = {
    1 => [0,         0],
    2 => [250000.0,  0.2],
    3 => [750000.0,  0.2],
    4 => [1500000.0, 0.35],
    5 => [3500000.0, 0.25]
  }

  def next_level_cost
    LEVELS[level + 1][0]
  end

  def next_training_fields_cost
    TRAINING_FIELDS[level + 1][0]
  end

  validates :title, presence: true, uniqueness: true, length: { maximum: 24 }
  validates_format_of :title, with: /\A[-A-Za-z0-9@_. ]+\z/
  validates :level, presence: true, inclusion: { in: 1..5 }
  validates :capacity, presence: true, inclusion: { in: [20, 22, 24, 26, 30] }
  validates :training_fields, presence: true, inclusion: { in: 1..5 }
  validates :experience_up, presence: true, inclusion: { in: 0.0..2.0 }
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