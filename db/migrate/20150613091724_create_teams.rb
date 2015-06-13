class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :user, index: true
      t.string :title, null: false, limit: 30, unique: true
      t.references :sponsor, index: true, null: false
      t.references :stadium, index: true
      t.references :club_basis, index: true
      t.decimal :budget, precision: 20, scale: 2, null: false
      t.integer :fans, null: false

      t.timestamps null: false
    end
    add_foreign_key :teams, :users
    add_foreign_key :teams, :sponsors
    add_foreign_key :teams, :stadia
    add_foreign_key :teams, :club_bases
  end
end
