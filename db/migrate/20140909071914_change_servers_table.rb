class ChangeServersTable < ActiveRecord::Migration
  def change
    change_column :servers, :votes, :integer, default: 0
  end
end
