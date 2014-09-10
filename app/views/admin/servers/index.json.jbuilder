json.array!(@admin_servers) do |admin_server|
  json.extract! admin_server, :id
  json.url admin_server_url(admin_server, format: :json)
end
