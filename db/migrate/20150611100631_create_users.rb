class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false, limit: 24, unique: true
      t.string :password_digest
      t.belongs_to :country
      t.string :sex
      t.date :birthday
      t.string :mail, null: false, unique: true
      t.integer :role
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
