class Player < ActiveRecord::Base
  include Definer
  # include Basic_Player

  # TODO добавить поля ХАРАКТЕРИСТИК (20!)!
  # 6 защитных: Отбор, Опека, Подкат, Выбор позиции, Лидерство, Прессинг
  # 6 атакующих: Удар, Дриблинг, Сила удара, Пас, Навес, Игра головой
  # 4 физических: Скорость, Выносливость, Реакция, Ловкость
  # 4 ментальных: Агрессивность, Популярность, Креативность, Амбициозность
  # TODO написать функцию, распределяющую level РАНДОМНО на эти хар-ки
  # TODO добавить их во вьюху тренировки(сделать) + на просмотр!!!
  belongs_to :country
  belongs_to :team
  has_many :transfers

  POSITIONS = %w(Gk Ld Cd Rd Lm Cm Rm Lf Cf Rf)

  enum status: [
    :active,
    :injured,
    :penalty_redcard,
    :penalty_yellowcards,
    :transfer
  ]

  before_validation :set_price, on: :create

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :country_id, presence: true
  validates :position1, presence: true, inclusion: { in: 0..9 }
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true
  validates :number, inclusion: { in: 1..99 }, allow_blank: true
  validates :state, inclusion: { in: 0..2 }

  def full_position_name
    return POSITIONS[position1] if position2.nil?
    POSITIONS[position1] + '/' + POSITIONS[position2]
  end

  def set_price
    self.price = (talent * skill_level * 10000 / age).round(3) if price.blank?
  end

  def self.search(search)
    #TODO сделать крутой поиск
    if search
      where('state = ? and (name LIKE ? or position1 = ?)', 1, '%' + search + '%', search.to_i )
    else
      where('state = ?', 1)
    end
  end

  def set_price
    self.price ||= ((skill_level * talent * 10000) / age.to_f).round(3)
  end

  def quality
    ld = self.level_define
    cel = ld / 2
    ost = ld % 2
    quality_l = 5 - cel - ost
    [cel, ost, quality_l]
  end
  # TODO добавить метод, определяющий возможность выбора POSITION2
end