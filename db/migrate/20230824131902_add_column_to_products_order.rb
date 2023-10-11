class AddColumnToProductsOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :products_orders, :quantity, :integer
    add_column :products_orders, :unit_price, :integer
    add_column :products_orders, :total_price, :integer
  end
end
