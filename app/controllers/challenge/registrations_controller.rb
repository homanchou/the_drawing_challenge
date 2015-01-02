class Challenge::RegistrationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @current_challenge = Challenge.current.first
  end

  def create
    @current_challenge = Challenge.current.first
    UserRegisterChallenge.new(current_user, @current_challenge).register!
    redirect_to confirmation_challenge_registrations_path
  rescue => e
    flash[:error] = e.to_s
    redirect_to root_path
  end

  def confirmation
    if !UserRegisterChallenge.new(current_user, @current_challenge).registered?
      redirect_to root_path
      return false
    end
    #confirm registration
  end

end
