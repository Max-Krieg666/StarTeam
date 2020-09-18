# == Schema Information
#
# Table name: operations
#
#  id         :uuid             not null, primary key
#  team_id    :uuid
#  kind       :boolean
#  title      :string
#  sum        :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Operation < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :team, inverse_of: :operations

  def sum_to_currency
    number_to_currency(sum, locale: :en, precision: 3)
  end
end
