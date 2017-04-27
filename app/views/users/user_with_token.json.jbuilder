json.user do
  json.(@user, :id, :username)
end
json.token(Auth.create_token(@user.id))
