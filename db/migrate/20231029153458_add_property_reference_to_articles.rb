class AddPropertyReferenceToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :property, null: false, foreign_key: true
  end
end
