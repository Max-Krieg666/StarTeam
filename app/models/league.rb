class League < ActiveRecord::Base
  require 'round_robin_tournament'

  belongs_to :country
  has_many :team_leagues

  enum status: [
    :waiting,
    :active,
    :finished
  ]

  def human_title
    I18n.t("leagues.title.#{title}")
  end

  def status_name
    I18n.t("leagues.statuses.#{status}")
  end

  def members_count
    team_leagues.size
  end

  def generate_grid # турнирная сетка
    # не более 24 (!) команд!!!!!
    teams_in_leagues = RoundRobinTournament.schedule(team_leagues)

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
