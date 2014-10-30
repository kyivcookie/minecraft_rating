class AddColumnToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :timestamp, :integer, default: 0
  end
end
