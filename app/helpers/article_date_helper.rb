module ArticleDateHelper
  def display_timestamp(article)
    if article.created_at != article.updated_at
      "Updated on: #{article.updated_at.strftime('%b %d, %Y')}"
    else
      article.created_at.strftime('%b %d, %Y')
    end
  end
end
