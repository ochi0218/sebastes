json.array!(@provide_users) do |provide_user|
  json.extract! provide_user, :id
  json.url provide_user_url(provide_user, format: :json)
end
