class Level_check < ActiveModel::Validator
  def validate(record)
    if condition
      record.errors.add :level, 'Слишком низкий уровень стадиона для постройки новых мест!'
    end
  end

  private
  def condition
    record.capacity>1000 && record.level==1 ||
      record.capacity>5000 && record.level==2 ||
        record.capacity>20000 && record.level==3 ||
          record.capacity>50000 && record.level==4
  end
end
class Stadium < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :team

  validates :team_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates_numericality_of :capacity, presence: true,
    greater_than_or_equal_to: 0, only_integer: true
  validates :level, presence: true, inclusion: { in: 1..5 }

  validates_with Level_check, on: :update
end
# level 1 --> COST: FREE  ;  capacity 200-1 000 [default]
## seatcost: $500
# level 2 --> COST: $200 000  ;  capacity 1 001-5 000
## seatcost: $400
# level 3 --> COST: $500 000  ;  capacity 5 001-20 000
## seatcost: $300
# level 4 --> COST: $1 000 000  ;  capacity 20 001-50 000
## seatcost: $200
# level 5 --> COST: $2 500 000  ;  capacity 50 001>
## seatcost: $100