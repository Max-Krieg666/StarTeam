class Game < ActiveRecord::Base
  belongs_to :home, class_name: 'Team'
  belongs_to :guest, class_name: 'Team'

  def simulation
    set_teams

  end

  def calculate_event
    set_teams
  end

  def set_teams
  	@home_team = self.home
  	@home_team_squad = @home_team.players
  	@home_team_main_squad = @home_team.players.where(basic: true)
  	@home_team_reserve_squad = @home_team.players.where(basic: false)
  	@guest_team = self.guest
  	@guest_team_squad = @guest_team.players
  	@guest_team_main_squad = @guest_team.players.where(basic: true)
  	@guest_team_reserve_squad = @guest_team.players.where(basic: false)
  end
end
