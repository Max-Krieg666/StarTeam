class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :player_id, index: true
      t.uuid :vendor_id, index: true, class_name: 'Team'
      t.uuid :purchaser_id, index: true, class_name: 'Team'
      t.float :cost, null: false
      t.integer :status

      t.timestamps null: false
    end
  end
end
