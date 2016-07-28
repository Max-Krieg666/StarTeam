class Player < ActiveRecord::Base
  include Definer
  belongs_to :country

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :country_id, presence: true
  validates :position1, presence: true, inclusion: { in: @@posit }
  validates :position2, inclusion: { in: [nil] + @@posit }
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  before_save :set_price

  def self.search(search)
    if search
      where('inteam = ? and (name LIKE ? or position1 LIKE ?)', false, "%" + search + "%","%" + search + "%")
    else
      where('inteam = ?', false)
    end
  end

  def set_price
    self.price ||= ((skill_level * talent * 10000) / age.to_f).round(3)
  end
end