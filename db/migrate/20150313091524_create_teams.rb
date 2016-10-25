class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :user_id, index: true
      t.string :title, null: false, limit: 30, unique: true
      t.decimal :budget, precision: 20, scale: 2, null: false
      t.integer :fans, null: false

      t.timestamps null: false
    end
  end
end
