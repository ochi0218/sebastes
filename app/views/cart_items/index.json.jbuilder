json.array!(@cart_items) do |cart_item|
  json.extract! cart_item, :id, :cart_id, :item_id, :quantity
  json.url cart_item_url(cart_item, format: :json)
end
