# == Schema Information
#
# Table name: formations
#
#  id     :uuid             not null, primary key
#  name   :string
#  schema :string
#

class Formation < ApplicationRecord
  has_many :teams, inverse_of: :formation
end
