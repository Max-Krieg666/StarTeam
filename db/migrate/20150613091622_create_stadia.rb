class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia do |t|
      t.string :title, null: false, limit: 100, unique: true
      t.integer :capacity, null: false
      t.integer :level, null: false
      t.belongs_to :team, index: true, unique: true

      t.timestamps null: false
    end
    add_foreign_key :stadia, :teams
  end
end
