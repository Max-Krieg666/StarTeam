class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :home_id, index: true, class_name: 'Team'
      t.uuid :guest_id, index: true, class_name: 'Team'
      t.string :tournament_id # id турнира
      t.boolean :kind # тип турнира... - cup / false или league / true
      t.integer :home_goals, default: 0
      t.integer :tour
      t.integer :guest_goals, default: 0
      t.datetime :starting_time
      # t.uuid :referee_id # id арбитра - на перспективу
      
      t.timestamps null: false
    end
  end
end
