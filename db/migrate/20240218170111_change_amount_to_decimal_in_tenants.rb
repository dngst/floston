class ChangeAmountToDecimalInTenants < ActiveRecord::Migration[7.0]
  def change
    change_column :tenants, :amount_due, :decimal, precision: 8, scale: 2
  end
end
