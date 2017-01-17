class Career < ActiveRecord::Base
  belongs_to :player

  scope :active, -> { where(active: true) }

  def age_period
  	return age_begin if age_begin == age_end
  	return "#{age_begin} - #{I18n.t('views.careers.now_end')}" unless age_end
    "#{age_begin} - #{age_end}"
  end
end
