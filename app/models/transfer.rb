# == Schema Information
#
# Table name: transfers
#
#  id           :uuid             not null, primary key
#  player_id    :uuid
#  vendor_id    :uuid
#  purchaser_id :uuid
#  cost         :float            not null
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Transfer < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  belongs_to :player, inverse_of: :transfers
  belongs_to :vendor, class_name: 'Team', inverse_of: :transfers
  belongs_to :purchaser, class_name: 'Team', inverse_of: :transfers

  STATUSES = %i[active completed canceled].freeze

  enum status: STATUSES

  validates :player_id, presence: true
  validates :vendor_id, presence: true
  validates :purchaser_id, presence: true, if: :completed?

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
