class CreateGameStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :game_statistics, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :game, type: :uuid
      t.integer :home_goals
      t.integer :home_shots, default: 0
      t.integer :home_shots_at_target, default: 0
      t.integer :home_corners, default: 0
      t.integer :home_fouls_committed, default: 0
      t.integer :home_yellow_cards, default: 0
      t.integer :home_red_cards, default: 0
      t.integer :home_offsides, default: 0
      t.integer :home_ball_possession, default: 0

      t.integer :guest_goals
      t.integer :guest_shots, default: 0
      t.integer :guest_shots_at_target, default: 0
      t.integer :guest_corners, default: 0
      t.integer :guest_fouls_committed, default: 0
      t.integer :guest_yellow_cards, default: 0
      t.integer :guest_red_cards, default: 0
      t.integer :guest_offsides, default: 0
      t.integer :guest_ball_possession, default: 0
      
      t.timestamps null: false
    end
  end
end
