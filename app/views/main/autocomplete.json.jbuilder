json.lists do
  json.array!(@lists) do |list|
    json.title list.title
    json.url list_path(list)
  end
end

json.users do
  json.array!(@users) do |user|
    json.name user.name
    json.url user_path(user)
  end
end
