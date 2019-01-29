class CreateCupsAndAssociationsWithTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :cups, id: :uuid, default: 'uuid_generate_v4()' do |t|
      # Кубковые соревнования
      t.belongs_to :country
      t.string :title, null: false # название
      t.integer :current_stage # текущая стадия
      t.integer :count, default: 0 # кол-во команд
      t.integer :status, default: 0 # статус
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
 
    create_table :team_cups, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :team, type: :uuid, index: true
      t.references :cup, type: :uuid, index: true

      t.integer :division # дивизион (если есть)
      t.integer :stage # стадия турнира

      # а надо ли >>?
      t.integer :games, default: 0
      t.integer :goals, default: 0
      t.integer :goals_conceded, default: 0
    end
  end
end
