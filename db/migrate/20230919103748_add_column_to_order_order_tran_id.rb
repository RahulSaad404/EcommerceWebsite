class AddColumnToOrderOrderTranId < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_trans_id, :string
  end
end
