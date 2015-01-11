class VotingService

  def initialize(challenge)
    @challenge = challenge
  end

  #get a random participant entry from this challenge, exclude this participant
  def get_random_post(exclude_participant = nil)
    entries = @challenge.entries
    entries = entries.where.not(id: exclude_participant.id) if exclude_participant
    num_of_entries = entries.count
    raise "Cannot produce random entry" if num_of_entries == 0
    offset = rand(num_of_entries)
    return entries.first(:offset => offset)
  end

  #get two random posts
  def two_random_posts
    left = get_random_post
    right = get_random_post(left)
    return left, right
  end

#this is a utility function that returns a ranking score based on pos, neg votes
  def ci_lower_bound(pos,neg)
    z= 1.96
    n = pos + neg
    return 0.0000001 if n == 0 #some reasonably small score that puts us slightly above negative votes, when we have no data
    phat = 1.0*pos/n
    return (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

#sets voting score for regular or battle votes
#passing in :battle => true, if voting on battle
#pass in :winner => 3, :loser => 5, the post_ids
  def record_vote(winner, loser)
    return false unless winner && loser
    winner.wins += 1
    loser.losses += 1
    winner.rank = ci_lower_bound(winner.wins, winner.losses)
    loser.rank = ci_lower_bound(winner.wins, winner.losses)
    winner.save!
    loser.save!
    return true
  end

end