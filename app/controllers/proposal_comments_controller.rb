class ProposalCommentsController < ApplicationController

  def create
      comment = ProposalComment.create(comment_params)
      #set_problem
      redirect_to problem_proposal_path(comment.proposal.problem, comment.proposal)
  end



  private

  def comment_params
    params.require(:proposal_comment).permit(:content, :proposal_id, :user_id, user_attributes:[:email])
  end

  def set_problem
    @problem = Problem.find_by_id(params[:problem_id])
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

end
