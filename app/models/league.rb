class League < ActiveRecord::Base
  require 'round_robin_tournament'

  belongs_to :country
  has_many :team_leagues

  enum status: [
    :waiting,
    :active,
    :finished
  ]

  def percentage
    # percent of complete
    (teams_size / 24.0 * 100).round
  end

  def teams_size
    team_leagues.size
  end

  def human_title
    I18n.t("leagues.title.#{title}")
  end

  def status_name
    I18n.t("leagues.statuses.#{status}")
  end

  def members_count
    team_leagues.size
  end

  def start
    generate_grid
    active!
    start_time = DateTime.now
    save!
  end

  def generate_grid # турнирная сетка
    # не более 24 (!) команд!!!!!
    games = RoundRobinTournament.schedule(team_leagues.to_a).map { |games| games.shuffle! }
    games = games + games.reverse.map do |tour|
        tour.shuffle.map { |pair| pair.reverse }
      end

    games.each_with_index do |tour, number|
      tour.each do |pair|
        next if pair.first.nil? || pair.last.nil?
        home = pair.first.team
        guest = pair.last.team
        Game.create(
          home_id: home.id,
          guest_id: guest.id,
          tournament_id: id,
          kind: true,
          starting_time: DateTime.current + (number + 2).days,
          tour: number + 1
        )
      end
    end
    return
  end
end
