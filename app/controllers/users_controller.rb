class UsersController < ApplicationController

  def profile_edit
    if current_user.first_name.present? or current_user.last_name.present? or current_user.mob_no.present? or current_user.address.present?
      @addresses = current_user.addresses
    else
      flash[:alert] = "First create your first and last name and mob_no. ,DOB and Address "
      redirect_to edit_user_registration_path
    end
  end

end
