class AddPropertyReferenceToTenants < ActiveRecord::Migration[7.0]
  def change
    add_reference :tenants, :property, null: false, foreign_key: true
  end
end
