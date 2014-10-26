module ApplicationHelper


  def is_admin?
    UserPermission.new(current_user).is_admin?
  end

end
