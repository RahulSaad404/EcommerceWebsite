class AddColumnToOrdersTotalBill < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :total_bill, :integer
  end
end
