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


end
