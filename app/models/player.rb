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

  scope :free_agent, -> { where(state: :free_agent) }

  POSITIONS = [
    :gk,
    :ld, :cd, :rd,
    :lm, :cm, :rm,
    :lf, :cf, :rf
  ].freeze

  enum position1: POSITIONS

  enum state: [
    :free_agent,
    :in_team,
    :retired
  ]

  enum status: [
    :active,
    :injured,
    :penalty_redcard,
    :penalty_yellowcards,
    :transfer
  ]

  before_validation :set_price, on: :create
  before_validation :set_real_position, on: :create

  validates :name, presence: true, uniqueness: { scope: [:position1, :age, :skill_level, :talent] }, length: { maximum: 50 }
  validates :country_id, presence: true
  validates :position1, presence: true
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true
  validates :number, inclusion: { in: 1..99 }, allow_blank: true

  def full_position_name
    # сделать позиции с заглавных букв!!!
    return position1 if position2.nil?
    position1 + '/' + position2
  end

  def real_position_name
    # TODO this
    # POSITIONS[real_position]
  end

  def set_price
    self.price ||= (skill_level * talent * 10000 / age.to_f).round(3)
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

  def is_position_defend?
    [:ld, :cd, :rd].include?(position1)
  end

  def is_position_midfield?
    [:lm, :cm, :rm].include?(position1)
  end

  def is_position_attack?
    [:lf, :cf, :rf].include?(position1)
  end

  def change_efficienty
    # TODO доделать вычисление эффекивности
    if position1 == real_position
      1.0
    else
    end
  end

  def self.calc_price(skill_level, talent, age)
    (skill_level * talent * 10000 / age.to_f).round(3)
  end
end
