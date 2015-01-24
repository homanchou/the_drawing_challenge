class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def ensure_admin
    unless UserPermission.new(current_user).is_admin?
      flash[:error] = "You don't have permission to access that page."
      redirect_to root_path
      return false
    end
  end

  def index
  end

end