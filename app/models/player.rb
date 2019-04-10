# == Schema Information
#
# Table name: players
#
#  id                    :uuid             not null, primary key
#  name                  :string(50)       not null
#  country_id            :bigint(8)
#  position1             :integer          not null
#  position2             :integer
#  efficienty            :float            default(1.0)
#  talent                :integer          not null
#  age                   :integer          not null
#  skill_level           :integer          not null
#  price                 :float            not null
#  state                 :integer          default("free_agent")
#  training_points       :integer          default(0)
#  tackling              :integer          default(0)
#  marking               :integer          default(0)
#  positioning           :integer          default(0)
#  heading               :integer          default(0)
#  pressure              :integer          default(0)
#  shot_accuracy         :integer          default(0)
#  shot_power            :integer          default(0)
#  dribbling             :integer          default(0)
#  passing               :integer          default(0)
#  carport               :integer          default(0)
#  speed                 :integer          default(0)
#  endurance             :integer          default(0)
#  reaction              :integer          default(0)
#  aggression            :integer          default(0)
#  creativity            :integer          default(0)
#  team_id               :uuid
#  special_skill1        :string(2)
#  num_sp_s1             :integer
#  special_skill2        :string(2)
#  num_sp_s2             :integer
#  special_skill3        :string(2)
#  num_sp_s3             :integer
#  number                :integer
#  season_games          :integer          default(0)
#  all_games             :integer          default(0)
#  season_goals          :integer          default(0)
#  all_goals             :integer          default(0)
#  season_passes         :integer          default(0)
#  all_passes            :integer          default(0)
#  season_conceded_goals :integer          default(0)
#  all_conceded_goals    :integer          default(0)
#  season_autogoals      :integer          default(0)
#  all_autogoals         :integer          default(0)
#  season_yellow_cards   :integer          default(0)
#  all_yellow_cards      :integer          default(0)
#  season_red_cards      :integer          default(0)
#  all_red_cards         :integer          default(0)
#  status                :integer          default("active")
#  basic                 :boolean          default(FALSE)
#  can_play              :boolean          default(TRUE)
#  games_missed          :integer          default(0)
#  injured               :boolean          default(FALSE)
#  captain               :boolean
#  morale                :integer          default(5)
#  physical_condition    :float            default(1.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  real_position         :integer
#

class Player < ApplicationRecord
  include Definer
  include PositionMethods
  include ActionView::Helpers::NumberHelper

  # 5 защитных: Отбор, Опека, Выбор позиции, Игра головой, Прессинг
  # 5 атакующих: Точность удара, Сила удара, Дриблинг, Пас, Навес
  # 3 физических: Скорость, Выносливость, Реакция
  # 2 ментальных: Агрессивность, Креативность

  belongs_to :country, inverse_of: :players
  belongs_to :team, inverse_of: :players, optional: true
  has_many :transfers, inverse_of: :player
  has_many :careers, inverse_of: :player
  has_many :game_events, inverse_of: :player
  has_many :game_players, inverse_of: :player

  def to_param
    return id if self.class.where(name: name).size > 1
    name.tr(' ', '+')
  end

  def self.find(input)
    return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
    find_by_name(input.tr('+', ' '))
  end

  def find_by_name(input)
    find_by name: input
  end

  GK_POSITION = %i[gk].freeze
  DEF_POSITIONS = %i[ld cd rd].freeze
  MID_POSITIONS = %i[lm cm rm].freeze
  ATT_POSITIONS = %i[lf cf rf].freeze
  POSITIONS = GK_POSITION + DEF_POSITIONS + MID_POSITIONS + ATT_POSITIONS

  STATES = %i[free_agent in_team retired].freeze

  STATUSES = %i[
    active
    injured penalty_redcard penalty_yellowcards
    transfer
  ].freeze

  CHARACTERISTICS = %i[
    tackling marking positioning heading pressure
    shot_accuracy shot_power dribbling passing carport
    speed endurance reaction
    aggression creativity
  ].freeze

  UNIQUENESS_NAME_SCOPE_WITH = %i[position1 age skill_level talent].freeze

  enum position1: POSITIONS
  enum state: STATES
  enum status: STATUSES

  before_validation :set_real_position, on: :create, if: -> { basic? }
  before_validation :set_price, on: :create

  validates :name,
            presence: true,
            uniqueness: { scope: UNIQUENESS_NAME_SCOPE_WITH },
            length: { maximum: 50 }
  validates :country_id, presence: true
  validates :position1, presence: true
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true
  validates :number, inclusion: { in: 1..99 }, allow_blank: true

  def full_position_name
    return position1.capitalize unless position2
    position1.capitalize + '/' + POSITIONS[position2].capitalize
  end

  def real_position_name
    return unless real_position
    POSITIONS[real_position].capitalize
  end

  def set_price
    self.price ||= (skill_level * talent * 10_000 / age.to_f).round(3)
  end

  def set_real_position
    self.real_position ||= POSITIONS.index(position1.to_sym)
  end

  def quality
    ld = level_define
    cel = ld / 2
    ost = ld % 2
    quality_l = 5 - cel - ost
    [cel, ost, quality_l]
  end

  def price_to_currency
    number_to_currency(price, locale: :en, precision: 3)
  end

  def show_special_skills
    return 'Нет спец. умений' if special_skill1.blank?
    str = special_skill1 + "-#{num_sp_s1}"
    str += ' / ' + special_skill2 + "-#{num_sp_s2}" if special_skill2
    str += ' / ' + special_skill3 + "-#{num_sp_s3}" if special_skill3
    str
  end

  def choose_position2
    AVAILABLE_POSITIONS_FOR_CHOOSING[position1]
  end

  def skill_level_with_efficienty
    (skill_level * efficienty).round
  end

  def positions_compare?
    POSITIONS.index(position1.to_sym) == real_position ||
      POSITIONS.index(position2&.to_sym) == real_position
  end

  def change_efficienty
    ef1 = POSITION_EFFICIENCY_MODEL[position1][real_position]
    return ef1 unless position2
    ef2 = POSITION_EFFICIENCY_MODEL[position2][real_position]
    [ef1, ef2].max
  end

  def self.calc_price(skill_level, talent, age)
    (skill_level.to_i * talent.to_i * 10_000 / age.to_f).round(3)
  end
end
