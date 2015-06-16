json.array!(@players) do |player|
  json.extract! player, :id, :name, :country_id, :position1, :position2, :talent, :age, :skill_level, :price
  json.url player_url(player, format: :json)
end
