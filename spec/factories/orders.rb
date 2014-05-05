FactoryGirl.define do
  factory :order do
    user_id 1
    order_number '1234567890abcdef'
    date '2014-01-01 12:00:00'
    destination_zip_code '1234567'
    destination_address '愛媛県松山市ほげ町1-1-1'
    destination_name 'テスト太郎'
    payment_method 1
    fee 1200
    delivery_fee 100
    delivery_date '2014-04-15'
    delivery_time_zone 1
  end
end
