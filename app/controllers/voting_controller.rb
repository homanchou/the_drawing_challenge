class VotingController < ApplicationController

  before_action :authenticate_user!

  def show
    begin
      previous_challenge = Challenge.previous
      raise "No previous challenge to vote on" if previous_challenge.nil?
      vs = VotingService.new(previous_challenge)
      @left, @right = vs.two_random_posts
    rescue => e
      flash[:error] = e.to_s
      redirect_to root_path
    end
  end

  def create
    begin
      winner_id, loser_id = Base64.decode64(params[:ballot]).split(',')
      previous_challenge = Challenge.previous
      winner = previous_challenge.entries.find(winner_id)
      loser = previous_challenge.entries.find(loser_id)
      vs = VotingService.new(previous_challenge)
      vs.record_vote(current_user,winner,loser)
      redirect_to voting_path
    rescue => e
      flash[:error] = "Error, vote not recorded"
      redirect_to root_path
    end
  end

end
