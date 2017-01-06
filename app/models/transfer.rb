class Transfer < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
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
    when 'active'
      '#32CD32'
    when 'completed'
      '#5CACEE'
    else
      '#FF3030'
    end
  end

  def cost_to_currency
    number_to_currency(cost, locale: :en, precision: 3)
  end
end
