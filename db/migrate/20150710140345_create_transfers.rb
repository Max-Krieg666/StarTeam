class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.belongs_to :player, index: true, class_name: 'PlayerInTeam'
      t.references :vendor, index: true, class_name: 'Team'
      t.references :purchaser, index: true, class_name: 'Team'
      t.float :cost
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :transfers, :players
    add_foreign_key :transfers, :vendors
    add_foreign_key :transfers, :purchasers
  end
end
