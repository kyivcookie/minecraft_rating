json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :category_id, :owner_id, :created_at
  json.url article_url(article, format: :json)
end
