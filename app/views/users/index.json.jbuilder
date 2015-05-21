json.array!(@users) do |user|
  json.extract! user, :id, :username, :role, :password_hash, :password_salt, :active
  json.url user_url(user, format: :json)
end
