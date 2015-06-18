class AddNoneToPlayerInTeam < ActiveRecord::Migration
  def change
    add_column :player_in_teams, :none, :boolean, default: false
  end
end
