class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.integer :category_id, default: 0
      t.integer :owner_id, default: 0
      t.integer :created_at, default: 0

      t.timestamps
    end
  end
end
