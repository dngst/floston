class AddUniqueConstraintToUnitNumberInTenant < ActiveRecord::Migration[7.0]
  def change
    add_index :tenants, :unit_number, unique: true
  end
end
