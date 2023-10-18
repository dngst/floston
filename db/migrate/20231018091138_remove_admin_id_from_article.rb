class RemoveAdminIdFromArticle < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :admin_id, :integer
  end
end
