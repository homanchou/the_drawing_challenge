class UserRegisterChallenge

  def initialize(user, challenge)
    @user = user
    @challenge = challenge
  end

  def registered?
    return false if @user.nil?
    @user.participating_in?(@challenge)
  end

  def register!
    raise "Login required" if @user.nil?
    raise "Already registered" if @user.participating_in?(@challenge)
    raise "Challenge Ended" if @challenge.ended?
    @user.participate!(@challenge)
  end



end