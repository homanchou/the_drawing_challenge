require 'rails_helper'

describe UserManageEntry do

  let(:user) {
    double('user')
  }
  let(:challenge) {
    double('challenge')
  }

  context "submit_entry!" do
    it "should raise error if not registered" do
      allow(user).to receive(:participating_in?).and_return(false)
      allow(user).to receive(:submitted_for_challenge?).and_return(true)
      allow(challenge).to receive(:ended?).and_return(false)
      ume = UserManageEntry.new(user, challenge)
      expect {ume.submit_entry!(title, description, url)}.to raise_error
    end

    it "should raise error if already submitted entry" do
      allow(user).to receive(:participating_in?).and_return(true)
      allow(user).to receive(:submitted_for_challenge?).and_return(true)
      allow(challenge).to receive(:ended?).and_return(false)
      ume = UserManageEntry.new(user, challenge)
      expect {ume.submit_entry!(title, description, url)}.to raise_error
    end

    it "should raise error if challenge ended" do
      allow(user).to receive(:participating_in?).and_return(true)
      allow(user).to receive(:submitted_for_challenge?).and_return(false)
      allow(challenge).to receive(:ended?).and_return(true)

      ume = UserManageEntry.new(user, challenge)
      expect {ume.submit_entry!(title, description, url)}.to raise_error
    end
  end





end