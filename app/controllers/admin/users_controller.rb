class Admin::UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "Thanks for adding, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    @user = User.find( params[:id] )
    @user.destroy

    redirect_to admin_users_path, notice: "User deleted successfully!"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
