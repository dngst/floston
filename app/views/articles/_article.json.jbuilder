# frozen_string_literal: true

json.extract! article, :id, :title, :body, :user_id, :published, :created_at, :updated_at
json.url article_url(article, format: :json)
