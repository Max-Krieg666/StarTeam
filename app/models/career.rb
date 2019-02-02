# == Schema Information
#
# Table name: careers
#
#  id         :uuid             not null, primary key
#  player_id  :uuid
#  team_title :string           not null
#  age_begin  :integer          not null
#  age_end    :integer
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Career < ApplicationRecord
  belongs_to :player, inverse_of: :careers

  scope :active, -> { where(active: true) }

  def age_period
    return age_begin if age_begin == age_end
    return "#{age_begin} - #{I18n.t('views.careers.now_end')}" unless age_end
    "#{age_begin} - #{age_end}"
  end
end
