class AddColumnToOrderAddressOrderAdd < ActiveRecord::Migration[6.0]
  def change
    add_column :order_addresses, :order_add, :string
  end
end
