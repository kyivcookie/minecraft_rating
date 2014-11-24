class CreateServersToCategories < ActiveRecord::Migration
  def change
    create_table :servers_to_categories do |t|
      t.integer :category_id
      t.integer :server_id

      t.timestamps
    end
  end
end
