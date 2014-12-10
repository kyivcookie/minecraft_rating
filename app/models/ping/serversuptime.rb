class Serversuptime < ActiveRecord::Base
  # establish_connection(
  #     :adapter  => 'mysql2',
  #     :database => 'minecraft_rating',
  #     :username => 'root',
  #     :host     => 'localhost',
  #     :password => '',
  # )

  establish_connection(
      :adapter  => 'mysql2',
      :database => 'mincraft_rating',
      :username => 'unrealm',
      :host     => 'localhost',
      :password => 'hjujdyj',
  )

  self.table_name = 'uptimes'
end