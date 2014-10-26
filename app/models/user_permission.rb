class UserPermission

  def initialize(user)
    @user = user
  end

  def set_admin!
    @user.role = 'admin'
  end

  def is_admin?
    return false if @user.nil?
    @user.role == 'admin'
  end

  def unset_admin!
    @user.role = nil
  end

end