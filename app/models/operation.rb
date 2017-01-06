class Operation < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :team

  def sum_to_currency
    number_to_currency(sum, locale: :en, precision: 3)
  end
end
