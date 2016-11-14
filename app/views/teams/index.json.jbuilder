json.array!(@teams) do |team|
  json.extract! team, :id, :user_id, :title, :sponsor, :stadium, :club_base, :budget, :fans
  json.url team_url(team, format: :json)
end
