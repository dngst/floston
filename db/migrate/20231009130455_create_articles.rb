class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :admin_id, null: false
      t.boolean :published, default: false, null: false

      t.timestamps
    end
  end
end
