class UserMailer < ApplicationMailer

  def send_thanks_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Successfully signed_upsss')
  end

	def order_placed_email(user_details)
    @user = user_details
    mail(to: @user.email, subject: 'Order Placed')
  end

  def product_available_mail(user_details,product_details)
    @user = user_details
    @product = product_details
    mail(to: @user.email, subject: 'Product Available')
  end
  
end
