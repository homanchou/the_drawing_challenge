class UserManageEntry
  def initialize(user, challenge)
    @user = user
    @challenge = challenge
  end

  def submit_entry!(title, description, image_url)
    raise "Not registered for challenge" unless @user.participating_in?(@challenge)
    raise "Already submitted" if @user.submitted_for_challenge?(@challenge)
    raise "Challenge ended" if @challenge.ended?
    @user.submit_for_challenge!(@challenge, title, description, image_url)
  end


end