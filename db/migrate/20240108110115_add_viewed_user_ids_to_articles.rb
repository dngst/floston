class AddViewedUserIdsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :viewed_user_ids, :text
  end
end
