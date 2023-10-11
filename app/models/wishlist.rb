class Wishlist < ApplicationRecord
	has_many :product_wishlists, dependent: :destroy
	has_many :products, through: :product_wishlists
	belongs_to :user
end
