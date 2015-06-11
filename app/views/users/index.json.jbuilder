json.array!(@users) do |user|
  json.extract! user, :id, :login, :password_digest, :residence, :sex, :birthday, :mail, :role, :avatar
  json.url user_url(user, format: :json)
end
