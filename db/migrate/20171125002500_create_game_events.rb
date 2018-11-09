class CreateGameEvents < ActiveRecord::Migration
  def change
    create_table :game_events, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.belongs_to :game, type: :uuid
      t.belongs_to :player, type: :uuid
      t.integer :kind
      t.string :minute
    end
  end
end
