class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    redirect_to comment.problem
  end



  private

  def comment_params
    params.require(:comment).permit(:content, :problem_id, :user_id, user_attributes:[:email])
  end


end
