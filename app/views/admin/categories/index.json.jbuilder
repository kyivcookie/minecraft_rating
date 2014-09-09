json.array!(@categories) do |category|
  json.extract! category, :id, :name, :parent_id
  json.url admin_category_url(category, format: :json)
end
