class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = params[:user][:type].constantize.new(user_params)

    if @user.save
      token = JwtService.encode(user_id: @user.id)
      session[:token] = token

      redirect_to projects_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :type)
  end
end
