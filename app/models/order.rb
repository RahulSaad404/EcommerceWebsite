class Order < ApplicationRecord
  belongs_to :user
  has_many :products_orders, dependent: :destroy
  has_many :products, through: :products_orders
  has_many :transections, dependent: :destroy
  has_one :order_address, dependent: :destroy
  has_one :address, through: :order_address

  enum order_status: { placed: 'placed', delivered: 'delivered', created: 'created', cancelled: 'cancelled' }
  enum payment_method: {Cash_on_Delivery: 'Cash on delivery',Online: 'Online'}
  
  scope :only_placed, -> {where("order_status=? OR order_status=? OR order_status=?", 'placed', 'delivered','cancelled')}

end


#enum category: { rails: "Rails", react: "React" }, _default: "Rails"
#enum status: { claimed: 'claimed', unverified: 'unverified',verified: 'verified'}, default: 'claimed'

                                            