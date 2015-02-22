json.array!(@users) do |user|
  json.extract! user, :id, :user_name, :role, :password_hash, :password_salt, :active
  json.url user_url(user, format: :json)
end
