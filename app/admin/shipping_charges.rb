ActiveAdmin.register ShippingCharge do
  config.filters = false
  menu parent: 'settings'
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :ship_charge
  #
  # or
  #
  # permit_params do
  #   permitted = [:ship_charge]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :ship_charge, :less_than, :greater_than

  if ShippingCharge.any?             
    actions :all, except: :new
  end

  show do 
    attributes_table do
      row :ship_charge
      row :less_than
      row :created_at
      row :updated_at
    end
  end

end
