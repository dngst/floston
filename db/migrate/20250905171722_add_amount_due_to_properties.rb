class AddAmountDueToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :amount_due, :decimal, precision: 8, scale: 2
  end
end
