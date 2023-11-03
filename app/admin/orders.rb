ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :order_trans_id, :order_status, :user_id, :shipping_charge, :taxes, :sub_total, :total_bill #, user_attributes:[:id, :email, :first_name, :_destroy], product_attributes:[]
  # belongs_to :user
  # or
  #
  # permit_params do
  #   permitted = [:order_status, :user_id, :total_bill, :shipping_charge, :taxes, :sub_total, :order_trans_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #permit_params :shipping_status
  actions :index, :show, :edit, :update

  # member_action :edit, method: :put do
  #   debugger
  #   resource.created!
  #   redirect_to admin_orders_path, notice: "created"
  # end
 filter :order_status
 filter :payment_method
 filter :paid, as: :check_boxes

    form do |f|
      f.semantic_errors # shows errors on :base
      f.inputs do 
        f.input :order_status, as: :select, collection: Order.order_statuses.keys
        f.input :order_trans_id, input_html: { disabled: true }        
        f.input :sub_total, input_html: { disabled: true }        
        f.input :shipping_charge, input_html: { disabled: true }
        f.input :taxes, input_html: { disabled: true } 
        f.input :total_bill, input_html: { disabled: true }
        f.input :paid, input_html: { disabled: true}
        f.inputs 'user', for: [:user, order.user] do |u|
          u.input :email, input_html: { disabled: true }
          u.input :first_name, input_html: { disabled: true }
        end
      end
      f.actions         # adds the 'Submit' and 'Cancel' buttons
   end

  index do 
    selectable_column
    column :id
    column :order_trans_id
    column :order_status
    column :sub_total do |obj|
      "₹#{obj.sub_total}"
    end
    column :shipping_charge
    column :taxes do |obj|
      "₹#{obj.taxes}"
    end
    column :total_bill do |obj|
      "₹#{obj.total_bill}"
    end
    column :payment_method
    column :paid
    column :created_at
    column :updated_at
    #row(:region) { |o| o.region.name }
    column :user do |o|
      link_to  o.user.first_name,admin_user_path(o.user_id)
    end 
    actions only: :show
  end

  show do
    attributes_table do
      row :order_status
      row :payment_method
      row :order_trans_id
      row :sub_total do |obj|
      "₹#{obj.sub_total}"
      end
      row :shipping_charge
      row :taxes do |obj|
      "₹#{obj.taxes}"
      end
      row :total_bill do |obj|
      "₹#{obj.total_bill}"
      end
      row :paid
    end
    panel "Products" do
      table_for order.products do
        column :product_name
        column :product_price
        column :product_brand
      end
    end
  end  

  sidebar "User", only: :show do
    attributes_table_for order.user do
      row :email
      row :first_name
      row :last_name
      row :mob_no
    end
  end
  
end
