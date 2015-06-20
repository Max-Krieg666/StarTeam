class AddPosToPlayerInTeam < ActiveRecord::Migration
  def change
    add_column :player_in_teams, :pos, :integer
  end
end
