class GameStatistic < ActiveRecord::Base
  belongs_to :game

  def result
    "#{home.title} - #{guest.title} #{simple_result_home}"
  end

  def simple_result_home
    return '-:-' unless home_goals
    "#{home_goals}:#{guest_goals}"
  end

  def simple_result_guest
    return '-:-' unless guest_goals
    "#{guest_goals}:#{home_goals}"
  end
end
