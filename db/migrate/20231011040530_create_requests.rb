class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
