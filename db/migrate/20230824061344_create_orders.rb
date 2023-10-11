class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_status, default: "created"
      t.timestamps
    end
  end
end
