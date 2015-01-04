class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order(created_at: :desc).page params[:page]
  end


  private

end
