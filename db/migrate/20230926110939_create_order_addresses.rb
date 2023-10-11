class CreateOrderAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :order_addresses do |t|
      t.integer :order_id
      t.integer :address_id
      t.timestamps
    end
  end
end
