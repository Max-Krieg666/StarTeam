class CreateClubBases < ActiveRecord::Migration
  def change
    create_table :club_bases, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.uuid :team_id, index: true, unique: true
      t.string :title, null: false, unique: true, length:30
      t.integer :level, null: false, default: 1
      t.integer :capacity, null: false, default: 20
      t.integer :training_fields, null: false, default: 1
      t.float :experience_up, null: false, default: 0.1

      t.timestamps null: false
    end
  end
end
