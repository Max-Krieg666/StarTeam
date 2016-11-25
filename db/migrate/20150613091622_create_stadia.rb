class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :title, null: false, limit: 100, unique: true
      t.integer :capacity, null: false, default: 200
      t.integer :level, null: false, default: 1
      t.references :team, type: :uuid

      t.timestamps null: false
    end
  end
end
