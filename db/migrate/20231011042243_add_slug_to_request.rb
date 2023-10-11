class AddSlugToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :slug, :string
    add_index :requests, :slug, unique: true
  end
end
