class DropArticles < ActiveRecord::Migration[8.0]
  def change
    drop_table :articles
  end
end
