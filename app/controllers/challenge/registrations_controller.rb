class Challenge::RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_challenge

  def new
  end

  def create
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
  end

  private

  def set_current_challenge
    @current_challenge = Challenge.current.first
  end

end
