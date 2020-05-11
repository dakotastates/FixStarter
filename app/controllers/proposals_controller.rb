class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  # GET /proposals.json
  def index
    @proposals = Proposal.all
  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
    set_proposal
    if params[:problem_id]
      set_problem
    end
  end

  # GET /proposals/new
  def new
      #@user = current_user
    if params[:problem_id]
      set_problem
      @proposal = @problem.proposals.build
      5.times {@proposal.materials.build}
    else
      @proposal = Proposal.new
      5.times {@proposal.materials.build}
    end
  end

  # GET /proposals/1/edit
  def edit
    if params[:problem_id]
      set_problem
      set_proposal
    else
      set_proposal
    end
  end

  # POST /proposals
  # POST /proposals.json
  def create
    if params[:problem_id]
      set_problem
      @proposal = @problem.proposals.build(proposal_params)
      @proposal.user = current_user
    else
      @proposal = Proposal.new(proposal_params)
    end ##

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to @proposal, notice: 'Proposal was successfully created.' }
        format.json { render :show, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    if params[:problem_id]
      set_problem
      set_proposal
      respond_to do |format|
        if @proposal.update(proposal_params)
          format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
          format.json { render :show, status: :ok, location: @proposal }
        else
          format.html { render :edit }
          format.json { render json: @proposal.errors, status: :unprocessable_entity }
        end
      end
    else

    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    if params[:problem_id]
  set_problem
  set_proposal
  @proposal.destroy
    redirect_to problem_path
  else
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposal was successfully destroyed.' }
      format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proposal_params
      params.require(:proposal).permit(:title, :content, materials_attributes:[:id, :name, :quantity])
      #, :user_id, :problem_id
    end

    def set_problem
      @problem = Problem.find_by_id(params[:problem_id])
    end
end
