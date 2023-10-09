json.extract! article, :id, :title, :body, :admin_id, :published, :created_at, :updated_at
json.url article_url(article, format: :json)
