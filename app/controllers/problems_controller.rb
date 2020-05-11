class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  # GET /problems
  # GET /problems.json
  def index

    @users = User.all
    @categories = Category.all

    @problems = Problem.all


    if !params[:user].blank?
    @problems = Problem.by_user(params[:user])
    elsif !params[:date].blank?
      if params[:date] == "Today"
        @problems = Problem.from_today
      elsif params[:date] == "Yesterday"
        @problems = Problem.yesterday
      elsif params[:date] == "last_week"
        @problems = Problem.last_week
      else
        @problems = Problem.older
      end
    elsif !params[:category].blank?
      #@problems = Problem.problem_categories.by_category(params[:category])

    else
      # if no filters are applied, show all posts
      @problems = Problem.all
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    set_problem
    @votes = Vote.all
  end

  # GET /problems/new
  def new
    @problem = Problem.new
  end

  # GET /problems/1/edit
  def edit
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)
    @problem.user = current_user
    respond_to do |format|
      if @problem.save
        @problem.user = current_user
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_vote
  @problem = Problem.find_by(id:params[:id])
  @vote = Vote.new(vote_params)
  @vote.user = current_user

    if @vote.save
      @votes = Vote.all
      render "show"
    else
      render "show"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def problem_params
      params.require(:problem).permit(:title, :content, :status, category_ids:[], categories_attributes:[:name])
    end

    def vote_params
      params.require(:vote).permit(:proposal_id)
    end
end
