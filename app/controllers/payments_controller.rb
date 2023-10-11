class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :order

  def create
    @razorpay_order = RazorpayPayment::Payment.new.create_order_payment(@order.total_bill, 'TEST')
  end

  def verify
    transection = { razorpay_order_id: params[:razorpay_order_id], razorpay_payment_id: params[:razorpay_payment_id],razorpay_signature_id: params[:razorpay_signature] }
    @order.transections.create(transection)
    signature_status = RazorpayPayment::Payment.new.varify_payment(transection)
    if signature_status
      @order.transections.last.update(transection_status:'success')
       UserMailer.order_placed_email(current_user).deliver_now
      @order.update(order_status:'placed',payment_method:'Online',order_trans_id: "ORD"+"#{@order.id}".rjust(6,'0'), paid:true)
      @order.products_orders.each do |product|
        product.product.update(stock:product.product.stock - product.quantity)
      end
      flash[:notice] = "payment successfull"
      redirect_to root_path
    else 
      @order.transections.last.update(transection_status:'fail')
      flash[:alert] = "payment failed"
      redirect_to show_cart_orders_path
    end
  end
  
  private
    def order
      @order = Order.find(params[:id])
    end
end
