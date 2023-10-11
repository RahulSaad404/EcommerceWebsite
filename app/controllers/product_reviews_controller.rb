class ProductReviewsController < ApplicationController
	
	def new
		@product = Product.find(params[:id])
		@review = ProductReview.new
	end

	def create
		@product = create_reviews_params[:product_id]
		@product = @product.to_i
		@review = ProductReview.create(create_reviews_params)
		 	respond_to do |format|
     		format.js
    	end
	end

	def edit 
		@product = Product.find(params[:product_id])
		@review = ProductReview.find(params[:id])
		 respond_to do |format|
     		format.js
    	end
	end

	def update
    @review = ProductReview.find(params[:id])
    if @review.update(create_reviews_params)
      redirect_to product_path(@review.product_id)
    else
      render 'edit'
    end
	end

	def destroy
		@product = Product.find(params[:product_id])
		@review = ProductReview.find(params[:id])
		@review.destroy
		redirect_to product_path(@review.product_id)
	end

	private
	def create_reviews_params
		params.require(:product_review).permit(:product_id, :review, :user_id)
	end
end
