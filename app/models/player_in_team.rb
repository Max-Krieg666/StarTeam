class PlayerInTeam < ActiveRecord::Base
  include Definer
  belongs_to :team
  belongs_to :country
  has_many :transfers

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :country_id, presence: true
  validates :position1, presence: true, inclusion: { in: @@posit }
  validates :position2, inclusion: { in: [""]+@@posit }
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true
  validates :basic, inclusion: { in: [true, false] }
  validates :team_id, inclusion: { in: 0..1000000 } #0 зарезервирован и обозначает,что данной команды нет
  validates :none, inclusion: { in: [true, false] }
  validates :number, presence: true, inclusion: { in: 1..99 }, allow_nil: true
  validates :status, presence: true, inclusion: { in: %w(active injured transfer penalty(redcard) penalty(2yellowcards))}
end


