class WishlistsController < ApplicationController
  
  def create 
    @product=Product.find(params[:id])
    if current_user.wishlist.present?
      current_user.wishlist.products << @product
    else
      wishlist = current_user.create_wishlist
      wishlist.products << @product
    end
    respond_to do |format|
      format.js
    end
  end
  
   def add
    current_user.create_wishlist
    flash[:alert] = "Please ADD any Products to Wishlist"
    redirect_to root_path 
   end

  def show_wishlist
    @wishlistproducts = current_user.wishlist.product_wishlists
  end
  
  def remove_product_from_wishlist #remove_product_from_washlist
    @product =ProductWishlist.find_by(product_id:params[:id]) 
    @product.destroy
    respond_to do |format|
      if request.format.js?
        format.js
      else
       format.html {
         redirect_to :action => 'show_wishlist'
       }
      end
    end
  end
end