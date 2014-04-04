class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :point

      t.integer :lock_version, default: 0
      t.timestamps
    end
  end
end
