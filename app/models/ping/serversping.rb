class Serversping < ActiveRecord::Base
  establish_connection(
      :adapter  => 'mysql2',
      :database => 'mincraft_rating',
      :username => 'unrealm',
      :host     => 'localhost',
      :password => 'hjujdyj',
  )
  self.table_name = 'servers'
end