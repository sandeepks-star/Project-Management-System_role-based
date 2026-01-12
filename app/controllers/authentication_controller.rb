class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:new, :login]

  def new
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JwtService.encode(user_id: @user.id)

      session[:token] = token

      redirect_to projects_path
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:token] = nil
    redirect_to login_path
  end
end
