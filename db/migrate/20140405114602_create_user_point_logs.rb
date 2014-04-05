class CreateUserPointLogs < ActiveRecord::Migration
  def change
    create_table :user_point_logs do |t|
      t.integer :user_id
      t.datetime :log_date
      t.integer :kind
      t.integer :change_point
      t.integer :before_point
      t.text :description

      t.timestamps
    end
  end
end
