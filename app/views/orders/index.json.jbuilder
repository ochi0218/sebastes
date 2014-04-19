json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :order_number, :date, :destination_zip_code, :destination_address, :destination_name, :payment_method, :fee, :delivery_fee, :use_point, :delivery_date, :delivery_time_zone_start, :delivery_time_zone_end
  json.url order_url(order, format: :json)
end
