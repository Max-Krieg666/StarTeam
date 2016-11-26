class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :title
      t.string :title_en # TODO добавить отображение этого поля на вьюхах+модель+контроллер!
      t.attachment :flag

      t.timestamps null: false
    end
  end
end
