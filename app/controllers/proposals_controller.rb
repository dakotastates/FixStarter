class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]


  def index
    @proposals = Proposal.all
  end


  def show
    set_proposal

    if params[:problem_id]
      set_problem

    end
  end


  def new

    if params[:problem_id]
      set_problem
      @proposal = @problem.proposals.build
      5.times {@proposal.materials.build}
    else
      @proposal = Proposal.new
      5.times {@proposal.materials.build}
    end
  end


  def edit
    if params[:problem_id]
      set_problem
      set_proposal
    else
      set_proposal
    end
  end


  def create
    if params[:problem_id]
      set_problem
      @proposal = @problem.proposals.build(proposal_params)
      @proposal.user = current_user
    else
      @proposal = Proposal.new(proposal_params)
    end ##

      if @proposal.save
        redirect_to problem_proposal_path(@proposal.problem, @proposal), notice: 'Proposal was successfully created.'
      else
        render :new
      end
  end


  def update
    if params[:problem_id]
      set_problem
      set_proposal
        if @proposal.update(proposal_params)
        redirect_to @proposal, notice: 'Proposal was successfully updated.'
        else
          render :edit
        end
    else

      if @proposal.update(proposal_params)
        redirect_to @proposal, notice: 'Proposal was successfully updated.'
      else
        render :edit
      end
  end
  end


  def destroy
    if params[:problem_id]
  set_problem
  set_proposal
  @proposal.destroy
    redirect_to problem_path
  else
    @proposal.destroy
      redirect_to proposals_url, notice: 'Proposal was successfully destroyed.'
      end
  end

  private
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    def proposal_params
      params.require(:proposal).permit(:title, :content, materials_attributes:[:id, :name, :quantity])
    end

    def set_problem
      @problem = Problem.find_by_id(params[:problem_id])
    end
end
