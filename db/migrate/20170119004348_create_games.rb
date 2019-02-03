class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :home_id, index: true, class_name: 'Team'
      t.uuid :guest_id, index: true, class_name: 'Team'
      t.references :tournament, type: :uuid, polymorphic: true, index: true
      t.integer :tour
      t.datetime :starting_time
      # t.uuid :referee_id # id арбитра - на перспективу
      
      t.timestamps null: false
    end
  end
end
