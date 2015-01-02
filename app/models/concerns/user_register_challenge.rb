class UserRegisterChallenge

  def initialize(user, challenge)
    @user = user
    @challenge = challenge
  end

  def registered?
    return false if @user.nil?
    !!@user.participations.where(challenge_id: @challenge.id).first
  end

  def register!
    raise "Login required" if @user.nil?
    @user.participations.create!(challenge: @challenge)
  end



end