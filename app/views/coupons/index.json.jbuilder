json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :code, :point, :used, :used_datetime
  json.url coupon_url(coupon, format: :json)
end
