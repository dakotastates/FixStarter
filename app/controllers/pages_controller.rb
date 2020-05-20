class PagesController < ApplicationController
  def home
    @user = current_user
    if @user != nil
      @problems = @user.problems

      @proposals = @user.proposals
    end
  end

  private
  def set_problem
    @problem = Problem.find(params[:id])
  end
end
