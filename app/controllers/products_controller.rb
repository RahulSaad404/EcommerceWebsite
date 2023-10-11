class ProductsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :search]
  
  def index
    if params[:id].present?
      @category = Category.find(params[:id])
      @products= @category.products
    else
  	  @products = Product.all
    end
  end

  def show 
  	@product = Product.find(params[:id])
  end 

  def search
    if params[:search].blank?
      @products = Product.all
      render 'index'
    else
      @products = params[:search]
      @products = Product.where("lower(product_name) LIKE :search",search: "%#{@products}%")
      render 'index'
     end  
  end

  def create_product_notify
    @product = Product.find(params[:id])
    current_user.notifies.create(product_id:@product.id)
    respond_to do |format|
      format.js
    end
  end

end
