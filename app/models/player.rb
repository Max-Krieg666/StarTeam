class Player < ActiveRecord::Base
  include Definer
  belongs_to :country

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  validates :position1, presence: true, inclusion: { in: @@posit }
  validates :position2, inclusion: { in: [""]+@@posit }
  validates :talent, presence: true, inclusion: { in: 1..9 }
  validates :age, presence: true, inclusion: { in: 16..39 }
  validates :skill_level, presence: true, inclusion: { in: 1..200 }
  validates :price, presence: true

  def self.search(search)
    if search
      where('inteam = ? and (name LIKE ? or position1 LIKE ?)',false,"%"+search+"%","%"+search+"%")
    else
      where('inteam = ?',false)
    end
  end
end