class Admin::UsersController < Admin::BaseController

  def index
    @users = User.order(:lastname).page params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "User Updated"
    else
      render :edit
    end
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
    UserMailer.account_deleted_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully!"
  end

  protected

  def user_params
    params.require(:user).permit(:id, :email, :firstname, :lastname, :password, :password_confirmation)
  end

end
