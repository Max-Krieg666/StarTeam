class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name, null: false, unique: true, limit: 50
      t.belongs_to :country, index: true
      t.integer :position1, null: false
      t.integer :position2
      t.integer :real_position # реальная позиция
      t.float :efficienty, default: 1.0 # эффективность игрока на позиции
      t.integer :talent, null: false
      t.integer :age, null: false
      t.integer :skill_level, null: false
      t.float :price, null: false
      t.integer :state, default: 0 # 0 - свободен, 1 - в команде, 2 - завершил карьеру
      
      # характеристики
      t.integer :training_points, default: 0 # очки тренировок
      # защитные (5)
      t.integer :tackling, default: 0 # Отбор
      t.integer :marking, default: 0 # Опека
      t.integer :positioning, default: 0 # Выбор позиции
      t.integer :heading, default: 0 # Игра головой
      t.integer :pressure, default: 0 # Прессинг
      # атакующие (5)
      t.integer :shot_accuracy, default: 0 # Точность удара
      t.integer :shot_power, default: 0 # Сила удара
      t.integer :dribbling, default: 0 # Дриблинг
      t.integer :passing, default: 0 # Пас
      t.integer :carport, default: 0 # Навес
      # физические (3)
      t.integer :speed, default: 0 # Скорость
      t.integer :endurance, default: 0 # Выносливость
      t.integer :reaction, default: 0 # Реакция
      # ментальные (2)
      t.integer :aggression, default: 0 # Агрессивность
      t.integer :creativity, default: 0 # Креативность

      # игрок в команде
      t.uuid :team_id, index: true
      t.string :special_skill1, limit: 2 # спецумение 1 #TODO integer
      t.integer :num_sp_s1 # уровень спецумения 1
      t.string :special_skill2, limit: 2 # спецумение 2
      t.integer :num_sp_s2 # уровень спецумения 2
      t.string :special_skill3, limit: 2 # спецумение 3
      t.integer :num_sp_s3 # уровень спецумения 3
      t.integer :number # номер в команде
      t.integer :season_games, default: 0 # игры в сезоне
      t.integer :all_games, default: 0 # всего игр за карьеру
      t.integer :season_goals, default: 0 # голы в сезоне
      t.integer :all_goals, default: 0 # всего голов за карьеру
      t.integer :season_passes, default: 0 # голевые пасы в сезоне
      t.integer :all_passes, default: 0 # голевые пасы за карьеру
      t.integer :season_conceded_goals, default: 0 # пропущено голов в сезоне for goalkeepers
      t.integer :all_conceded_goals, default: 0 # пропущено голов за карьеру for goalkeepers
      t.integer :season_autogoals, default: 0 # всего автоголов в сезоне
      t.integer :all_autogoals, default: 0 # всего автоголов за карьеру
      t.integer :season_yellow_cards, default: 0 # всего ж.к. в сезоне
      t.integer :all_yellow_cards, default: 0 # всего ж.к. за карьеру
      t.integer :season_red_cards, default: 0 # всего к.к. в сезоне
      t.integer :all_red_cards, default: 0 # всего к.к. за карьеру
      t.integer :status, default: 0 # статус игрока
      t.boolean :basic, default: false # основной состав, если true, иначе - запасной
      t.boolean :can_play, default: true # может ли играть игрок в след. матче
      t.integer :games_missed, default: 0 # сколько осталось пропустить матчей, чтобы начать играть
      t.boolean :injured, default: false # наличие травмы
      t.boolean :captain # капитан или нет
      t.integer :morale, default: 5 # мораль
      t.float :physical_condition, default: 1.0 # физ. готовность

      t.timestamps null: false
    end
  end
end
