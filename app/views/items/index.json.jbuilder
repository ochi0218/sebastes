json.array!(@items) do |item|
  json.extract! item, :id, :name, :image, :price, :description, :display_flag, :sort_no
  json.url item_url(item, format: :json)
end
