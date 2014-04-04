class AddLockVersionToProvideUser < ActiveRecord::Migration
  def change
    add_column :provide_users, :lock_version, :integer
  end
end
