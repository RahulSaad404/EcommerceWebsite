class CreateTransections < ActiveRecord::Migration[6.0]
  def change
    create_table :transections do |t|
      t.integer :order_id
      t.string :razorpay_order_id
      t.string :razorpay_payment_id
      t.string :razorpay_signature_id
      t.string :transection_status
      t.timestamps
    end
  end
end
