class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :login, null: false, limit: 24, unique: true
      t.belongs_to :country
      t.string :sex
      t.date :birthday
      t.integer :role
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
