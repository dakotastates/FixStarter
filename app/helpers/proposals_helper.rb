module ProposalsHelper
  def created(proposal)
  proposal.created_at.strftime("%m-%d-%y %H:%M")
end
end
