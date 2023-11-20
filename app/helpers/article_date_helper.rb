module ArticleDateHelper
  def display_timestamp(article)
    if article.created_at == article.updated_at
      article.created_at.strftime('%b %d, %Y')
    else
      "Updated on #{article.updated_at.strftime('%b %d, %Y')}"
    end
  end
end
