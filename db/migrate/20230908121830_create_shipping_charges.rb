class CreateShippingCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_charges do |t|
      t.integer :ship_charge
      t.timestamps
    end
  end
end
