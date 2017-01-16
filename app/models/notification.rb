class Notification < ActiveRecord::Base
  belongs_to :user

  enum kind: [
    :user,
    :team,
    :buildings,
    :other
  ]
end
