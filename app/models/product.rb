class Product < ApplicationRecord
	belongs_to :category
	has_one_attached :image

	has_many :products_orders, dependent: :destroy
	has_many :orders, through: :products_orders
	
	has_many :product_wishlists, dependent: :destroy
	has_many :wishlists, through: :product_wishlists

	has_many :notifies, dependent: :destroy
	has_many :users, through: :notifies

	has_many :product_reviews, dependent: :destroy
	has_many :users, through: :product_reviews

	before_update :send_email

	validates :stock, presence: true
	validates :product_name, presence: true

	private
	  def send_email
	 		if self.stock_was == 0
	 			self.notifies.each do |notify|
	 				user = notify.user 
	 				UserMailer.product_available_mail(user,self).deliver_now
	 			end
	 			self.notifies.destroy_all
	 		end
		end
end
