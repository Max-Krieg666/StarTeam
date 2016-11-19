class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :title, null: false, limit: 100, unique: true
      t.integer :capacity, null: false
      t.integer :level, null: false
      t.belongs_to :team

      t.timestamps null: false
    end
  end
end
