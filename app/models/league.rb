class League < ActiveRecord::Base
  require 'round_robin_tournament'

  belongs_to :country
  has_many :teams_leagues

  def generate_grid # турнирная сетка
    # не более 24 (!) команд!!!!!
    teams = RoundRobinTournament.schedule(teams_leagues)

    teams.each_with_index do |pair, tour|
      home = pair.first.team
      guest = pair.last.team
      Game.create(
        home_id: home.id,
        guest_id: guest.id,
        tournament_id: self.id,
        kind: true,
        tour: tour + 1
      )
    end
  end
end
