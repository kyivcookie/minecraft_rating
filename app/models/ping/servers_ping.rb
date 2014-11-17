class ServersPing < ActiveRecord::Base
  establish_connection(
      :adapter  => 'mysql2',
      :database => 'minecraft_rating',
      :username => 'root',
      :host     => 'localhost',
      :password => '',
  )
  self.table_name = 'servers'
end