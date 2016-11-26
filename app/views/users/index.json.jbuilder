json.array!(@users) do |user|
  json.extract! user, :id, :login, :password, :residence, :sex, :birthday, :email, :role, :avatar
  json.url user_url(user, format: :json)
end
