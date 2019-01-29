class PlayerInGameSerializer < ActiveModel::Serializer
  attributes :id,
             :state,
             :injured,
             :can_play,
             :training_points,
             :season_games,
             :all_games,
             :season_goals,
             :all_goals,
             :season_passes,
             :all_passes,
             :season_conceded_goals,
             :all_conceded_goals,
             :season_autogoals,
             :all_autogoals,
             :season_yellow_cards,
             :all_yellow_cards,
             :season_red_cards,
             :all_red_cards
end