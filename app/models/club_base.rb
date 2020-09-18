# == Schema Information
#
# Table name: club_bases
#
#  id              :uuid             not null, primary key
#  team_id         :uuid
#  title           :string           not null
#  level           :integer          default(1), not null
#  capacity        :integer          default(20), not null
#  training_fields :integer          default(1), not null
#  experience_up   :float            default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ClubBase < ApplicationRecord
  include Finder

  DEFAULT_LEVEL = 5

  belongs_to :team, inverse_of: :club_base

  def to_param
    title.tr(' ', '+')
  end

  validates :title, presence: true, uniqueness: true, length: { maximum: 24 }
  validates_format_of :title, with: /\A[-A-Za-z0-9_ ]+\z/, message: :incorrect
  validates :level, presence: true, inclusion: { in: 1..5 }
  validates :capacity, presence: true, inclusion: { in: [20, 22, 24, 26, 30] }
  validates :training_fields, presence: true, inclusion: { in: 1..5 }
  validates :experience_up, presence: true, inclusion: { in: 0.0..2.0 }

  LEVELS = {
    1 => [0,           0,    20],
    2 => [50_000.0,    0.2,  22],
    3 => [400_000.0,   0.2,  24],
    4 => [1_000_000.0, 0.35, 26],
    5 => [2_500_000.0, 0.25, 30]
  }.freeze

  TRAINING_FIELDS = {
    1 => [0,           0],
    2 => [250_000.0,   0.2],
    3 => [750_000.0,   0.2],
    4 => [1_500_000.0, 0.35],
    5 => [3_500_000.0, 0.25]
  }.freeze

  def next_level_cost
    LEVELS[level + 1][0]
  end

  def next_training_fields_cost
    TRAINING_FIELDS[level + 1][0]
  end

  def max_level?
    level == DEFAULT_LEVEL
  end

  def max_training_fields?
    training_fields == DEFAULT_LEVEL
  end
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
