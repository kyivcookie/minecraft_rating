class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :ip
      t.integer :vip
      t.integer :port
      t.string :banner
      t.string :name
      t.string :country
      t.text :description
      t.string :website
      t.string :youtube_id
      t.integer :votes
      t.integer :disabled
      t.integer :status
      t.text :votifier_key
      t.string :votifier_ip
      t.string :votifier_port
      t.integer :players
      t.integer :max_players
      t.string :server_version
      t.text :cache_time
      t.integer :protocol

      t.timestamps
    end
  end
end
