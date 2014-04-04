class CreateCouponLogs < ActiveRecord::Migration
  def change
    create_table :coupon_logs do |t|
      t.datetime :used_datetime
      t.integer :coupon_id
      t.integer :user_id

      t.integer :lock_version, default: 0
      t.timestamps
    end
  end
end
