class OrdersController < ApplicationController
  before_action :find_create_order, only: [:show_cart, :add_shipping_address, :create, :remove_product_from_cart, :update_product_quantity, :payment_method, :update_payment_method_as_COD, :cancel_order ]

  def create
    @product = Product.find_by_id(params[:id])
    if @product.present?
      @created_order.products_orders.create(product_id: @product.id, quantity: 1, unit_price: @product.product_price, total_price: @product.product_price)
      update_order_total               
      respond_to do |format|
        format.js
      end
     else
       flash[:alert] = "Product is removed by seller"
       render 'products/index'
     end                                  
  end                                 

  def show_cart 
    @orderproducts = @created_order.products_orders
  end

  def add_shipping_address
    address = Address.find_by_id(params[:id])
    if address.present?
      if @created_order.order_address.present?
        @created_order.order_address.update(address_id:address.id, order_add:address.address)
      else
        @created_order.create_order_address(address_id:address.id,order_add:address.address)
      end    
    else
      flash[:alert] = "Order is not available"
    end
    redirect_to :action => 'show_cart'
  end

  def payment_method
    @created_order 
    respond_to do |format|
      format.js
    end
  end

  def update_payment_method_as_COD
    @created_order.update(payment_method:'Cash on delivery',order_status:'placed', order_trans_id: "ORD"+"#{@created_order.id}".rjust(6,'0'))
    @created_order.products_orders.each do |product|
      product.product.update(stock:product.product.stock - product.quantity)
    end
    UserMailer.order_placed_email(current_user).deliver_now
     flash[:notice] = "Order Placed"
      redirect_to root_path
  end

  def show_my_orders
    @orders = current_user.orders.only_placed.order(updated_at: :desc)
  end

  def order_details
    order = Order.find_by_id(params[:id])
    if order.nil?
      flash[:alert] = "Order is not available"
    else
      @order_details = Order.find(params[:id])
    end
  end

  def cancel_order
    order = Order.find(params[:id])
    order.update(order_status:'cancelled')
    flash[:alert] = "Order cancelled"
    redirect_to :action => 'order_details'
  end

  def update_product_quantity
    product_order = ProductsOrder.find_by_id(params[:id])
    if product_order.present?
      if params[:new_quantity].to_i > product_order.product.stock 
        flash[:alert] = "Not available"
      else
      product_order.update(quantity: params[:new_quantity],total_price: params[:new_quantity].to_i*params[:unit_price].to_i)
      update_order_total
      end
    else
      flash[:alert] = "Product is not available"
    end
      redirect_to :action => 'show_cart'
  end                               
                                        
  def remove_product_from_cart 
    product_order = ProductsOrder.find_by_id(params[:id])
    if product_order.nil?
      flash[:alert] = "Product already deleted from admin"
    else
      product_order.destroy        
      update_order_total              
    end
      redirect_to :action => 'show_cart'
  end
  
  private

  def update_order_total
    sub_total = @created_order.products_orders.pluck(:total_price).sum
    charge = ShippingCharge.last
    shipping_charge = (sub_total > charge.greater_than) ? 0 : charge.ship_charge
    taxes = sub_total*Tax.last.tax_percent/100
    @created_order.update_columns(shipping_charge: shipping_charge, taxes: taxes, sub_total: sub_total, total_bill: (sub_total+taxes+shipping_charge) )
  end

  def find_create_order
    @created_order = current_user.orders.find_or_create_by(order_status:'created')
  end

end
