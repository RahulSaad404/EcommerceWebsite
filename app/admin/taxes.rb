ActiveAdmin.register Tax do
  menu parent: 'settings'
  config.filters = false
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :tax_percent
  #
  # or
  #
  # permit_params do
  #   permitted = [:tax_percent]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  if Tax.any?             
    actions :all, except: :new
  end

  show do 
    attributes_table do
      row :tax_percent
      row :created_at
      row :updated_at
    end
  end
end
