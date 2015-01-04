class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  skip_before_action :verify_authenticity_token

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  end

end