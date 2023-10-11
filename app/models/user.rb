class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :office_addresses, dependent: :destroy, foreign_key: :user_id
  has_many :home_addresses, dependent: :destroy, foreign_key: :user_id
  has_many :addresses, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :notifies, dependent: :destroy
  has_many :products, through: :notifies
  has_many :product_reviews, dependent: :destroy
  has_many :products, through: :product_reviews
  after_create :send_email_for_signup


  private
    def send_email_for_signup
      UserMailer.send_thanks_mail(self).deliver_now
    end
end
