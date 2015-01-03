require 'rails_helper'

describe UserRegisterChallenge do

  let(:user) {
    double('user')
  }
  let(:challenge) {
    double('challenge')
  }

  context "register!" do
    it "should raise error if challenge ended already" do
      allow(user).to receive(:participating_in?).and_return(false)
      allow(challenge).to receive(:ended?).and_return(true)
      urc = UserRegisterChallenge.new(user, challenge)
      expect{urc.register!}.to raise_error
    end

    it "should raise error if already registered" do
      allow(user).to receive(:participating_in?).and_return(true)
      allow(challenge).to receive(:ended?).and_return(false)
      urc = UserRegisterChallenge.new(user, challenge)
      expect{urc.register!}.to raise_error
    end
  end


  context "registered?" do
    it "not participating in" do
      allow(user).to receive(:participating_in?).and_return(false)
      urc = UserRegisterChallenge.new(user, challenge)
      expect(urc.registered?).to be(false)
    end
    it "user is nil?" do
      user = nil
      urc = UserRegisterChallenge.new(user, challenge)
      expect(urc.registered?).to be(false)
    end

  end





end