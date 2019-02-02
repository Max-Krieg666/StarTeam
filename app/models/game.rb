# == Schema Information
#
# Table name: games
#
#  id            :uuid             not null, primary key
#  home_id       :uuid
#  guest_id      :uuid
#  tournament_id :string
#  kind          :boolean
#  tour          :integer
#  starting_time :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Game < ApplicationRecord
  belongs_to :home, class_name: 'Team', inverse_of: :games
  belongs_to :guest, class_name: 'Team', inverse_of: :games

  has_one :game_statistic

  has_many :game_events, dependent: :destroy
  has_many :game_players, dependent: :destroy

  def league? # игра лиги
    kind
  end

  def tournament
    klass = league? ? League : Cup
    klass.find(tournament_id)
  end

  def who_plays
    "#{home.title} - #{guest.title}"
  end

  def simulation
    game = Generator::GameEngine.new(home, guest)
    results = game.simulation
    ActiveRecord::Base.transaction do
      # TODO results saves to database
    end
    self
  end
end
