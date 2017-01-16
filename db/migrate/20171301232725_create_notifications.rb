class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :user, type: :uuid
      t.boolean :viewed, default: false
      t.string :title
      t.integer :kind
      
      t.timestamps null: false
    end
  end
end
