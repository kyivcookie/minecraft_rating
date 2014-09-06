json.array!(@servers) do |server|
  json.extract! server, :id, :user_id, :category_id, :ip, :vip, :port, :banner, :name, :country, :description, :website, :youtube_id, :votes, :disabled, :status, :votifier_key, :votifier_ip, :votifier_post, :players, :max_players, :server_version, :cache_time, :protocol
  json.url server_url(server, format: :json)
end
