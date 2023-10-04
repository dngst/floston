class AddUserReferenceToTenant < ActiveRecord::Migration[7.0]
  def change
    add_reference :tenants, :user, null: false, foreign_key: true
  end
end
