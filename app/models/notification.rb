# == Schema Information
#
# Table name: notifications
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  viewed     :boolean          default(FALSE)
#  title      :string
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user, inverse_of: :notifications

  enum kind: %i[user team buildings other]
end
