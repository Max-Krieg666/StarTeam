json.array!(@club_bases) do |club_basis|
  json.extract! club_basis, :id, :owner, :title, :level, :capacity, :training_fields, :experience_up
  json.url club_basis_url(club_basis, format: :json)
end
