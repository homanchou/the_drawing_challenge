class ChallengesController < ApplicationController

  def index
    @current_challenge = Challenge.current.first
    @ended_challenges = Challenge.ended.page params[:page]
    @user_register_challenge = UserRegisterChallenge.new(current_user, @current_challenge)
  end

  def show
  end


end
