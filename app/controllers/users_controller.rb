class UsersController < ApplicationController
  def new
  	@title = "Sign up"
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def show
  	@user =User.find(params[:id])
  end
end
