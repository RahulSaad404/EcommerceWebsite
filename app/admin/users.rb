ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :email, :first_name, :last_name, :dob, :address, :mob_no
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :first_name, :last_name, :dob, :address, :mob_no]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  actions :index,:show

  filter :email_cont, label: 'Email'
  filter :first_name_cont, label: 'First name'
  filter :last_name_cont, label: 'Last name'
  filter :mob_no_cont, label: 'Mobile No.'

  index do
    selectable_column
      column :email
      column :first_name
      column :last_name
      column :dob
      column :mob_no  
      actions only: :show
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :dob
      row :mob_no 
    end
  end  

end
