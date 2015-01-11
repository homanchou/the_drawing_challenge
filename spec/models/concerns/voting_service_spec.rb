require 'rails_helper'

describe VotingService do

  it "should get random post" do
    c = Challenge.create!(title:'new challenge', start_at:2.days.ago, end_at:5.days.from_now)
    10.times do
      c.participations.create!(submitted_at:Time.now)
    end
    vs = VotingService.new(c)
    expect(c.participations.pluck(:id).include?(vs.get_random_post.id)).to eq(true)
  end

  it "should create a voting record" do
    c = Challenge.create!(title:'new challenge', start_at:2.days.ago, end_at:5.days.from_now)
    5.times do
      c.participations.create!(submitted_at:Time.now)
    end
    #TODO, use factory girl for this
    user = User.create!(uid: Devise.friendly_token[0,20],
      password: Devise.friendly_token[0,20],
      name: Devise.friendly_token[0,20],
      email: "#{Devise.friendly_token[0,5]}@thing.com")

    vs = VotingService.new(c)
    left, right = vs.two_random_posts
    vs.record_vote(user, left, right)

    expect(user.votes.count).to eq(1)
    expect(user.votes.first.voting_history.first).to eq("#{left.id} > #{right.id}")


  end

end