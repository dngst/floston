class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.integer :amount, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
