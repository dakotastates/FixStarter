module ProblemsHelper
  def created(problem)
    problem.created_at.strftime("%m-%d-%y %H:%M")
  end

  def vote_count(proposal)
    proposal.votes.count
  end

def total_votes
   @sum = 0
   @problem.proposals.each do |proposal|
      @sum += proposal.votes.count
   end
  @sum
end

 def vote_results(proposal)
   (proposal.votes.count.to_f / total_votes) * 100
 end

 def max_vote
   @counter = 0
   @problem.proposals.each do |proposal|
     if proposal.votes.count > @counter
       @counter = proposal.votes.count
     end
    end
    @counter
  end

  def winner
    @numWinners = 0
    @winner = nil
    if @problem != nil
      @problem.proposals.each do |proposal|
        if proposal.votes.count == max_vote
          @numWinners +=1
          @winner = proposal
        end
      end
      if @numWinners == 1
        @winner
      end
    end
  end

end
