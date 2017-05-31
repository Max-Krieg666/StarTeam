class Cup < ActiveRecord::Base
  belongs_to :country
  has_many :team_cups

  def initiate_grid # первый раунд турнирной сетки кубкового турнира
    all_teams = team_cups.to_a.dup
    number = all_teams.size
    update(current_stage: 1, count: number)
    max_number = Math.log(all_teams.size, 2).ceil # ближайшая степень двойки
    rnd2 = max_number - number # число команд, начинающих со второго раунда
    rnd2_teams = a.sample(rnd2).each { |team_in_cup| team_in_cup.update!(stage: 2) }
    rnd1_teams = all_teams - rnd2_teams

    # матчи первого раунда кубкового турнира
    for i in 0...rnd1_teams.size
      team1 = rnd1_teams[i]
      team2 = rnd1_teams[rnd1_teams.size - 1 - i]
      create_cup_game(team1, team2, 1)
      create_cup_game(team2, team1, 1)
    end
  end
  
  # создание матчей новой стадии кубкового турнира
  def create_new_round(tour)
    update(current_stage: tour)
    # все команды, прошедшие в новую стадию кубкового турнира
    all_teams_in_round = team_cups.where(stage: tour).to_a
    size = all_teams_in_cup.size
    return false if size < 2

    if size == 2 # финал или 3 место
      create_cup_game(all_teams_in_round.first, all_teams_in_round.last, tour)
    else
      for i in 0...size
        team1 = all_teams_in_round[i]
        team2 = all_teams_in_round[size - 1 - i]
        create_cup_game(team1, team2, tour)
        create_cup_game(team2, team1, tour)
      end
    end
  end

  def create_final_games(tour)
    update(current_stage: tour)
    teams_in_final = team_cups.where(stage: tour).to_a
    teams_for_3rd_place = team_cups.where(stage: tour - 1).to_a
    # матч за 3 место
    create_cup_game(teams_for_3rd_place.first, teams_for_3rd_place.last, tour)
    # финал
    create_cup_game(teams_in_final.first, teams_in_final.last, tour + 1)
  end

  def create_cup_game(home, guest, round)
    Game.create(
      home_id: home.id,
      guest_id: guest.id,
      tournament_id: id,
      kind: false,
      starting_time: DateTime.current + 2.days,
      tour: round
    )
  end
end
