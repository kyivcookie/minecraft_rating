class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :server_id
      t.integer :user_id
      t.integer :amount
      t.integer :quantity
      t.string :payer_email
      t.text :description

      t.timestamps
    end
  end
end
