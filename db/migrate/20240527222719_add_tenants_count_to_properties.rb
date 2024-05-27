class AddTenantsCountToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :tenants_count, :integer, default: 0
  end
end
