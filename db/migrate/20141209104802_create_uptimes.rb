class CreateUptimes < ActiveRecord::Migration
  def change
    create_table :uptimes do |t|
      t.integer :server_id
      t.integer :down
      t.integer :up

      t.timestamps
    end
  end
end
