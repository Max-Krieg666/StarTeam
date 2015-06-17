json.array!(@player_in_teams) do |player_in_team|
  json.extract! player_in_team, :id, :special_skill1, :num_sp_s1, :special_skill2, :num_sp_s2, :special_skill3, :num_sp_s3, :number, :season_games, :all_games, :season_goals, :all_goals, :season_autogoals, :all_autogoals, :season_yellow_cards, :all_yellow_cards, :season_red_cards, :all_red_cards, :status, :can_play, :injured
  json.url player_in_team_url(player_in_team, format: :json)
end
