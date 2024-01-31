class AddViewCountToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :view_count, :integer, default: 0
  end
end
