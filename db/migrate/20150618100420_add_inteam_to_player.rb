class AddInteamToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :inteam, :boolean, default: false
  end
end
