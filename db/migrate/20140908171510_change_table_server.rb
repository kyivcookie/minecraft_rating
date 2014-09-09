class ChangeTableServer < ActiveRecord::Migration
  def change
    change_column :servers, :cache_time, :integer, :default => 0
  end
end
