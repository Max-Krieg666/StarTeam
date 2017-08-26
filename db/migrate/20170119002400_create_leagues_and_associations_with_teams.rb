class CreateLeaguesAndAssociationsWithTeams < ActiveRecord::Migration
  def change
    create_table :leagues, id: :uuid, default: 'uuid_generate_v4()' do |t|
      # Соревнования Лиги
      t.belongs_to :country
      t.string :title, null: false # название
      t.integer :count, default: 0 # кол-во команд
      t.integer :status, default: 0 # статус
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
 
    create_table :team_leagues, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :team, type: :uuid, index: true
      t.references :league, type: :uuid, index: true

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
