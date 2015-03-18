class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order(created_at: :desc).page params[:page]
  end

  def make_admin
    @user = User.find(params[:id])
    UserPermission.new(@user).set_admin!
    redirect_to admin_users_path
  end

  def unset_admin
    @user = User.find(params[:id])
    UserPermission.new(@user).unset_admin!
    redirect_to admin_users_path
  end


  private

end
