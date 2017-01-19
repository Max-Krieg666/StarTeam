class Cup < ActiveRecord::Base
  belongs_to :country
  has_many :teams_cups
end
