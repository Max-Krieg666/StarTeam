class Player < ActiveRecord::Base
  include Definer
  include Basic_Player
  belongs_to :country
  belongs_to :team
  has_many :transfers

  after_initialize :pos_define
  before_validation :set_price, on: :create

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :country_id, presence: true
  validates :position1, presence: true, inclusion: { in: @@posit }
  validates :position2, inclusion: { in: [nil] + @@posit }
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true
  validates :basic, inclusion: { in: [true, false] }
  validates :team_id, inclusion: { in: 0..1000000 }, allow_blank: true # 0 зарезервирован и обозначает, что данной команды нет
  validates :number, inclusion: { in: 1..99 }, allow_blank: true
  validates :status, presence: true, inclusion: { in: %w(active injured transfer penalty(redcard) penalty(2yellowcards))}
  validates :state, inclusion: { in: 0..2 }

  def set_price
    self.price = (talent * skill_level * 10000 / age).round(3) if price.blank?
  end

  def pos_define
    self.pos = right_alph_srt(self.position1)
  end

  def self.search(search)
    if search
      where('in_team = ? and (name LIKE ? or position1 LIKE ?)', false, '%' + search + '%', '%' + search + '%')
    else
      where('in_team = ?', false)
    end
  end

  def set_price
    self.price ||= ((skill_level * talent * 10000) / age.to_f).round(3)
  end
end