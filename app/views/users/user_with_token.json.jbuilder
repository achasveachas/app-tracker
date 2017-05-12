json.user do
  json.(@user, :id, :username, :name)
end
json.token(Auth.create_token(@user.id))
