class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :title
      t.string :title_en
      t.attachment :flag

      t.timestamps null: false
    end
  end
end
