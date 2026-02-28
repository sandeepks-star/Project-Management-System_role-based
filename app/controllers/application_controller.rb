class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Allow extra fields in Devise (name & role)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # Role Authorization for Manager
  def authorize_manager!
    unless current_user&.manager?
      redirect_to projects_path, alert: "Only Managers allowed"
    end
  end

  # Optional: Redirect after login
  def after_sign_in_path_for(resource)
    projects_path
  end

end