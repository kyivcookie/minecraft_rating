class CreateVotes < ActiveRecord::Migration
  def change
    create_table :server_votes do |t|
      t.integer :server_id
      t.integer :votes_count

      t.timestamps
    end
  end
end
