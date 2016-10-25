class Transfer < ActiveRecord::Base
  belongs_to :player
  belongs_to :vendor, class_name: 'Team'
  belongs_to :purchaser, class_name: 'Team'

  validates :player_id, presence: true
  validates :vendor_id, presence: true
  validates :status, inclusion: { in: %w(Активен Завершён Отменён) }
end
