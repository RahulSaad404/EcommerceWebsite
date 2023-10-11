class ApplicationController < ActionController::Base
	respond_to :html, :js

	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit([:sign_up], keys: [:first_name, :last_name, :dob, :address, :mob_no])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :dob, :address, :mob_no])
  end
end
