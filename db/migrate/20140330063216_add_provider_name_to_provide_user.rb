class AddProviderNameToProvideUser < ActiveRecord::Migration
  def change
    add_column :provide_users, :provider_name, :string
  end
end
