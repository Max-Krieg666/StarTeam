class League < ActiveRecord::Base
  require 'round_robin_tournament'

  belongs_to :country
  has_many :teams_leagues

  def generate_grid # турнирная сетка
    # не более 24 (!) команд!!!!!
    teams_in_leagues = RoundRobinTournament.schedule(teams_leagues)

    teams_in_leagues.each_with_index do |pair, tour|
      home = pair.first.team
      guest = pair.last.team
      Game.create(
        home_id: home.id,
        guest_id: guest.id,
        tournament_id: id,
        kind: true,
        starting_time: DateTime.current + (tour + 2).days,
        tour: tour + 1
      )
    end
  end
end
