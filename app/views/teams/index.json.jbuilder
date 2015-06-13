json.array!(@teams) do |team|
  json.extract! team, :id, :user_id, :title, :sponsor_id, :stadium_id, :club_base_id, :budget, :fans
  json.url team_url(team, format: :json)
end
