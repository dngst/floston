class SetDefaultViewCountForExistingArticles < ActiveRecord::Migration[7.0]
  def up
    Article.where(view_count: nil).update_all(view_count: 0)
  end
end
