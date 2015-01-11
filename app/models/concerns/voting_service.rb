class VotingService

  def initialize(challenge)
    @challenge = challenge
  end

  #get a random participant entry from this challenge, exclude this participant
  def get_random_post(exclude_participant = nil)
    entries = @challenge.entries
    entries = entries.where.not(id: exclude_participant.id) if exclude_participant
    num_of_entries = entries.count
    raise "Cannot produce random entry to vote on" if num_of_entries == 0
    offset = rand(num_of_entries)
    return entries.offset(offset).limit(1).first
  end

  #get two random posts
  def two_random_posts
    left = get_random_post
    right = get_random_post(left)
    return left, right
  end

  # http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
  #i was using this, but looking at the score, it doesn't work out well
  #or i didn't implement it correctly
  #in our case since voting image is randomize and there is always 1 winner and 1 loser
  #I think we can savely order by wins - loses

  #this is a utility function that returns a ranking score based on pos, neg votes
  # def ci_lower_bound(pos,neg)
  #   z= 1.96
  #   n = pos + neg
  #   return 0.0000001 if n == 0 #some reasonably small score that puts us slightly above negative votes, when we have no data
  #   phat = 1.0*pos/n
  #   return (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  # end


  def record_vote(voter, winner, loser)
    Vote.transaction do
      return false unless winner && loser
      winner.wins += 1
      loser.losses += 1
      winner.rank = winner.wins - winner.losses #ci_lower_bound(winner.wins, winner.losses)
      loser.rank = loser.wins - loser.losses #ci_lower_bound(winner.wins, winner.losses)
      winner.save!
      loser.save!
      vote = voter.votes.where(challenge_id: winner.challenge_id).first_or_initialize
      vote.voting_history << "#{winner.id} > #{loser.id}"
      vote.save!
      return true
    end
  end

end