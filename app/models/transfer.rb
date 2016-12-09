class Transfer < ActiveRecord::Base
  belongs_to :player
  belongs_to :vendor, class_name: 'Team'
  belongs_to :purchaser, class_name: 'Team'

  enum status: [
    :active,
    :completed,
    :canceled
  ]

  validates :player_id, presence: true
  validates :vendor_id, presence: true

  def statuses_in_colors
    case status
    when 0
      '#32CD32'
    when 1
      '#FF3030'
    else
      '#5CACEE'
    end
  end
end
