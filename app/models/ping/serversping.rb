class Serversping < ActiveRecord::Base
  establish_connection(
      :adapter  => 'mysql2',
      :database => 'mincraft_rating',
      :username => 'unrealm',
      :host     => 'localhost',
      :password => 'hjujdyj',
  )

  # establish_connection(
  #     :adapter  => 'mysql2',
  #     :database => 'minecraft_rating',
  #     :username => 'root',
  #     :host     => 'localhost',
  #     :password => '',
  # )

  self.table_name = 'servers'

  has_one :serversuptime, foreign_key: :server_id
end