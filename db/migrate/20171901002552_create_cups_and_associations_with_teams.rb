class CreateCupsAndAssociationsWithTeams < ActiveRecord::Migration
  def change
    create_table :cups, id: :uuid, default: 'uuid_generate_v4()' do |t|
      # Кубковые соревнования
      t.belongs_to :country
      t.string :title, null: false # название
      t.integer :current_stage # текущая стадия
      t.integer :count # кол-во команд
      # t.integer :kind -> ? # тип?
      # t.references :grid, type: :uuid # ТУРНИРНАЯ СЕТКА
      t.boolean :active, default: true # активен или нет

      t.timestamps null: false
    end
 
    create_table :teams_cups, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.belongs_to :team, index: true
      t.belongs_to :cup, index: true

      t.integer :division # дивизион (если есть)
      t.integer :stage # стадия турнира

      # а надо ли >>?
      t.integer :games, default: 0
      t.integer :goals, default: 0
      t.integer :goals_conceded, default: 0
    end
  end
end
