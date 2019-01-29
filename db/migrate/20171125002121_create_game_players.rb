class CreateGamePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_players, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.belongs_to :game, type: :uuid
      t.belongs_to :player, type: :uuid
      t.integer :goals, default: 0
      t.integer :shots, default: 0
      t.integer :shots_at_target, default: 0
      t.integer :fouls_committed, default: 0
      t.integer :yellow_cards, default: 0
      t.integer :red_cards, default: 0

      t.timestamps null: false
    end
  end
end
