class Challenge::ManageEntryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_challenge

  def edit
    graph = Koala::Facebook::API.new(current_user.oauth['credentials']['token'])
    permissions = graph.get_connections("me","permissions")
    if permissions.select {|x| x['permission'] == 'publish_actions'}.present?
      #show form
    else
      app_id = ENV['FACEBOOK_APP_ID']
      app_secret = ENV['FACEBOOK_APP_SECRET']
      callback_url = challenge_manage_entry_edit_url
      redirect_to Koala::Facebook::OAuth.new(app_id, app_secret, callback_url).
        url_for_oauth_code(:permissions => 'publish_actions')
    end
  rescue Koala::Facebook::AuthenticationError
    flash[:error] = "Please resign in with Facebook"
    sign_out_and_redirect(current_user)
  end

  def update

  end

  private

  def set_current_challenge
    @current_challenge = Challenge.current.first
  end

end
