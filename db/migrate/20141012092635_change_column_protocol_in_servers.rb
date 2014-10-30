class ChangeColumnProtocolInServers < ActiveRecord::Migration
  def change
    change_column :servers, :protocol, :integer, default: 0
  end
end
