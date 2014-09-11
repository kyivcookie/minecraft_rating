class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :voted_at, :integer, default: 0
  end
end
