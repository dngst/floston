class RemoveAmountDueFromTenants < ActiveRecord::Migration[8.0]
  def change
    remove_column :tenants, :amount_due, :decimal
  end
end
