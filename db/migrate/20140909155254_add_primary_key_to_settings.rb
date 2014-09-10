class AddPrimaryKeyToSettings < ActiveRecord::Migration
  def change
    change_column :settings, :key, :string, :default => false
  end
  execute 'ALTER TABLE settings ADD PRIMARY KEY (`key`)'
end
