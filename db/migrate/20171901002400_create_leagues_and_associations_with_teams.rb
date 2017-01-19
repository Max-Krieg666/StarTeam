class CreateLeaguesAndAssociationsWithTeams < ActiveRecord::Migration
  def change
    create_table :leagues, id: :uuid, default: 'uuid_generate_v4()' do |t|
      # Соревнования Лиги
      t.belongs_to :country
      t.string :title, null: false # название
      t.integer :season, null: false # сезон
      t.integer :count # кол-во команд
      # t.references :grid, type: :uuid # ТУРНИРНАЯ СЕТКА
      t.boolean :active, default: true

      t.timestamps null: false
    end
 
    create_table :teams_leagues, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.belongs_to :team, index: true
      t.belongs_to :league, index: true

      t.integer :division # дивизион
      t.integer :place # место команды
      t.integer :tour # тур
      t.integer :games, default: 0
      t.integer :goals, default: 0
      t.integer :goals_conceded, default: 0
      t.integer :wins, default: 0
      t.integer :draws, default: 0
      t.integer :loses, default: 0
      t.integer :points, default: 0
    end
  end
end