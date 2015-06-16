class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, null: false, unique: true, limit: 50
      t.belongs_to :country, index: true
      t.string :position1, null: false
      t.string :position2
      t.integer :talent, null: false
      t.integer :age, null: false
      t.integer :skill_level, null: false
      t.float :price, null: false

      t.timestamps null: false
    end
    add_foreign_key :players, :countries
  end
end
