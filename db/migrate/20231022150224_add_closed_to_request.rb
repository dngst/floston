class AddClosedToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :closed, :boolean, null: false, default: false
  end
end
