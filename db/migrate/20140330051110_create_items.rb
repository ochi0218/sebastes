class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.decimal :price
      t.text :description
      t.boolean :display_flag
      t.integer :sort_no
      t.integer :stock, default: 0
      
      t.integer :lock_version, default: 0
      t.timestamps
    end
  end
end
