json.array!(@diaries) do |diary|
  json.extract! diary, :id, :title, :contents, :image, :user_id
  json.url diary_url(diary, format: :json)
end
