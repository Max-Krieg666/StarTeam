class League < ApplicationRecord
  require 'round_robin_tournament'

  belongs_to :country, inverse_of: :leagues
  has_many :team_leagues

  enum status: %i[waiting active finished]

  def games
    Game.where(tournament_id: id)
  end

  def citizenships_info
    teams_ids = Team.joins(:team_leagues)
                    .where('team_leagues.league_id = ?', id)
                    .map(&:id)
    country_stat = Player.where(team_id: teams_ids).map(&:country_id)
    Hash[count_countries(country_stat).sort_by(&:last).reverse]
  end

  def sorted_teams
    team_leagues.order(
      'team_leagues.points desc, (team_leagues.goals - team_leagues.goals_conceded) desc, team_leagues.goals desc, team_leagues.games asc, team_leagues.wins desc'
    )
  end

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
    self.start_time = Time.current
    save!
  end

  def generate_grid # турнирная сетка
    # не более 24 (!) команд!!!!!
    games = RoundRobinTournament.schedule(team_leagues.to_a).map(&:shuffle!)
    games += games.reverse.map do |tour|
      tour.shuffle.map(&:reverse)
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
          starting_time: Time.current + (number + 2).days,
          tour: number + 1,
          game_statistic: GameStatistic.new
        )
      end
    end
  end

  private

  def count_countries(countries)
    countries.each_with_object({}) do |country, counter|
      counter[Country.find(country).title] += 1
    end
  end
end
