class Team < ActiveRecord::Base
  belongs_to :user
  has_one :sponsor
  has_one :stadium
  has_one :club_basis
end
