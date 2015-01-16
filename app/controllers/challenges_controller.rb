class ChallengesController < ApplicationController

  def index
    @current_challenge = Challenge.current.first
    @ended_challenges = Challenge.ended.page params[:page]
    @user_register_challenge = UserRegisterChallenge.new(current_user, @current_challenge)

    #list all challenges except current_challenge in reverse chronological order
    @challenges = Challenge.where.not(id: @current_challenge).order("id desc")

  end

  def show
  end


end
