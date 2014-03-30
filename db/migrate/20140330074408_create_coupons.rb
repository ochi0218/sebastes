class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :point
      t.boolean :used, default: false
      t.datetime :used_datetime

      t.timestamps
    end
  end
end
