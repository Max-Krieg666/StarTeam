class Operation < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  belongs_to :team, inverse_of: :operations

  def sum_to_currency
    number_to_currency(sum, locale: :en, precision: 3)
  end
end
