class Challenge::ManageEntryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_challenge

  def edit
  end

  def update
  end

  private

  def set_current_challenge
    @current_challenge = Challenge.current.first
  end

end
