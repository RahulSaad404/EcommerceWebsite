class AddColumnsToShippingChargesGreaterandLess < ActiveRecord::Migration[6.0]
  def change
    add_column :shipping_charges, :greater_than, :integer
  end
end
