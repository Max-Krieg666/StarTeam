class Player < ActiveRecord::Base
  include Definer
  include ActionView::Helpers::NumberHelper
  # include Basic_Player

  # 5 защитных: Отбор, Опека, Выбор позиции, Игра головой, Прессинг
  # 5 атакующих: Точность удара, Сила удара, Дриблинг, Пас, Навес
  # 3 физических: Скорость, Выносливость, Реакция
  # 2 ментальных: Агрессивность, Креативность

  belongs_to :country, inverse_of: :players
  belongs_to :team, inverse_of: :players
  has_many :transfers, inverse_of: :player
  has_many :careers, inverse_of: :player
  has_many :game_events
  has_many :game_players

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

  POSITIONS = %i[
    gk
    ld cd rd
    lm cm rm
    lf cf rf
  ].freeze

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

  DEFAULT_VALUES = {
    team_id: nil,
    state: :free_agent,
    status: :active,
    season_games: 0,
    season_goals: 0,
    season_passes: 0,
    season_conceded_goals: 0,
    season_autogoals: 0,
    season_yellow_cards: 0,
    season_red_cards: 0,
    can_play: true,
    games_missed: 0,
    captain: false,
    injured: false,
    morale: 5,
    physical_condition: 1.0,
    basic: false
  }.freeze

  UNIQUENESS_NAME_SCOPE_WITH = %i[position1 age skill_level talent].freeze

  enum position1: POSITIONS
  enum state: STATES
  enum status: STATUSES

  before_validation :set_price, on: :create
  before_validation :set_real_position, on: :create

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
    return position1.capitalize if position2.nil?
    position1.capitalize + '/' + position2.capitalize
  end

  def real_position_name
    # TODO this
    # POSITIONS[real_position]
  end

  def set_price
    self.price ||= (skill_level * talent * 10_000 / age.to_f).round(3)
  end

  def set_real_position
    self.real_position ||= position1
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
    # TODO this
    # case position1
    # when 1, 3 # Ld, Rd
    #   [2]
    # when 2 # Cd
    #   [1, 3]
    # when 4, 6 # Lm, Rm
    #   [5]
    # when 5 # Cm
    #   [4, 6]
    # when 7, 9 # Lf, Rf
    #   [8]
    # when 8 # Cf
    #   [7, 9]
    # else # 0 = Gk
    #   []
    # end
  end

  def position_defend?
    %i[ld cd rd].include?(position1)
  end

  def position_midfield?
    %i[lm cm rm].include?(position1)
  end

  def position_attack?
    %i[lf cf rf].include?(position1)
  end

  def change_efficienty
    # TODO доделать вычисление эффекивности
    if position1 == real_position
      1.0
    else
    end
  end

  def self.calc_price(skill_level, talent, age)
    (skill_level.to_i * talent.to_i * 10_000 / age.to_f).round(3)
  end
end
