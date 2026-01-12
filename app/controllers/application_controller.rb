class ApplicationController < ActionController::Base
  before_action :authorize_request

  helper_method :current_user

  private

  def current_user
    @current_user
  end

  def authorize_request
    header = session[:token]
    decoded = JwtService.decode(header)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue
    session[:token] = nil
    redirect_to login_path
  end

  def authorize_manager
    unless @current_user.is_a?(Manager)
      redirect_to projects_path, alert: "Only Managers can create Projects"
    end
  end

end
