class CreateCouponLogs < ActiveRecord::Migration
  def change
    create_table :coupon_logs do |t|
      t.datetime :used_datetime
      t.integer :coupon_id
      t.integer :user_id

      t.timestamps
    end
  end
end
