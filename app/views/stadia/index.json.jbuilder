json.array!(@stadia) do |stadium|
  json.extract! stadium, :id, :title, :capacity, :level, :team_id
  json.url stadium_url(stadium, format: :json)
end
