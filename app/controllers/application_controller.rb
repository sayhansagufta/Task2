class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  # Handle unauthorized access
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end


  protected
  def after_sign_in_path_for(resource)
    root_path # Ganti dengan path yang Anda inginkan setelah login
  end

  def record_not_found
    redirect_to root_path, alert: 'Record not found.'
  end
end
