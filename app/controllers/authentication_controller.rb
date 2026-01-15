class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [ :new, :login ]
  skip_before_action :if_current_user_is_nil
  def new
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JwtService.encode(user_id: @user.id)
      byebug
      session[:token] = token

      redirect_to projects_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:token] = nil
    redirect_to login_path
  end
end
