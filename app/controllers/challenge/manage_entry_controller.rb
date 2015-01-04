class Challenge::ManageEntryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_challenge
  before_action :ensure_participation

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
    current_user.submit_for_challenge!(@current_challenge,
      params[:participation][:title],
      params[:participation][:description],
      params[:participation][:image_url])
    flash[:notice] = "Entry Updated"
    redirect_to root_path
  end

  private

  def set_current_challenge
    @current_challenge = Challenge.current.first
  end

  def ensure_participation
    @participation = current_user.find_participation(@current_challenge)
    if @participation.nil?
      flash[:error] = "You are not registered for the current challenge, did you submit too late?"
      redirect_to root_path
      return false
    end
  end


end
