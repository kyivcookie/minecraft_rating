class ChangeTableServers < ActiveRecord::Migration
  def change
    change_column :servers, :cache_time, :boolean, :default => 0
    change_column :servers, :protocol, :boolean, :default => 1
    change_column :servers, :status, :boolean, :default => 1
    change_column :servers, :disabled, :boolean, :default => 0
    change_column :servers, :vip, :boolean, :default => 0
  end
end
