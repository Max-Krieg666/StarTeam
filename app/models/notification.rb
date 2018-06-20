class Notification < ActiveRecord::Base
  belongs_to :user, inverse_of: :notifications

  enum kind: [
    :user,
    :team,
    :buildings,
    :other
  ]
end
