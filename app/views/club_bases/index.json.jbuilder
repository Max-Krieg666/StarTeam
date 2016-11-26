json.array!(@club_bases) do |club_base|
  json.extract! club_base, :id, :owner, :title, :level, :capacity, :training_fields, :experience_up
  json.url club_base_url(club_base, format: :json)
end
