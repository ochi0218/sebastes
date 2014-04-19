class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :order_number
      t.datetime :date
      t.string :destination_zip_code
      t.string :destination_address
      t.string :destination_name
      t.integer :payment_method
      t.integer :fee
      t.integer :delivery_fee
      t.integer :use_point
      t.date :delivery_date
      t.integer :delivery_time_zone

      t.timestamps
    end
  end
end
