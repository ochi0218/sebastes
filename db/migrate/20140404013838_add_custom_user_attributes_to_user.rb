class AddCustomUserAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :nick_name, :string
    add_column :users, :profile_image, :string
    add_column :users, :destination_zip_code, :string
    add_column :users, :destination_address, :text
    add_column :users, :destination_name, :string
    add_column :users, :point, :integer, default: 0
  end
end
