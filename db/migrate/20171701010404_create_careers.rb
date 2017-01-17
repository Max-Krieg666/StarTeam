class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :player_id, index: true
      t.string :team_title, null: false
      t.integer :age_begin, null: false
      t.integer :age_end
      t.boolean :active, default: true
      
      t.timestamps null: false
    end
  end
end
