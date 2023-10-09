class CreateTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :tenants do |t|
      t.string :unit_number, null: false
      t.string :unit_type, null: false
      t.date :moved_in
      t.date :next_payment
      t.integer :amount_due

      t.timestamps
    end
  end
end
