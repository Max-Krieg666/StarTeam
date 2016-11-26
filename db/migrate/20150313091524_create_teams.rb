class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :user, type: :uuid
      t.string :title, null: false, limit: 30, unique: true
      t.decimal :budget, precision: 20, scale: 2, null: false, default: 250000.0
      t.integer :fans, null: false, default: 20
      t.belongs_to :country

      t.timestamps null: false
    end
  end
end
