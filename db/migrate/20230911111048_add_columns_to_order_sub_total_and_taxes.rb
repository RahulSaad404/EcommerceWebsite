class AddColumnsToOrderSubTotalAndTaxes < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :taxes, :integer, :default => 0
    add_column :orders, :sub_total, :integer, :default => 0
  end
end
