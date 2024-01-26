# frozen_string_literal: true

module ArticleDateHelper
  def display_timestamp(article)
    return unless article.created_at != article.updated_at

    "Updated on #{article.updated_at.strftime('%b %d, %Y')}"
  end
end
