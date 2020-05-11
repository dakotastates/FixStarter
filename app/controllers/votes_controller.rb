class VotesController < ApplicationController


  def create
  @problem = Problem.find_by(id:params[:id])
  @vote = Vote.new(vote_params)
  @vote.user = current_user

    if @vote.save
      @votes = Vote.all
      redirect_to @vote.proposal.problem
    else
      redirect_to @vote.proposal.problem
    end
  end


private
  def vote_params
    params.require(:vote).permit(:proposal_id)
  end
end
