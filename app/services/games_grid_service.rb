class GamesGridService
  def self.perform(league)
    resulted_hash = {}
    league.sorted_teams.each do |team_in_league|
      team = team_in_league.team
      homes = {}
      guests = {}

      Game.where(
        tournament_id: league.id,
        home_id: team.id
      ).each { |g| homes[g.guest] = g.game_statistic.simple_result_home }

      Game.where(
        tournament_id: league.id,
        guest_id: team.id
      ).each { |g| guests[g.home] = g.game_statistic.simple_result_guest }

      resulted_hash[team.title] = {
        home: homes,
        guest: guests
      }
    end
    resulted_hash
  end
end
