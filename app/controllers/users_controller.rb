class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Hawkins!"
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
