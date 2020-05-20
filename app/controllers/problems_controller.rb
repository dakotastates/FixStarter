class ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

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

    else
      @problems = Problem.all
    end
  end

  def show
    set_problem
    @votes = Vote.all
  end

  def new
    @problem = Problem.new
  end

  def edit
  end


  def create
    @problem = Problem.new(problem_params)
    @problem.user = current_user

      if @problem.save
        @problem.user = current_user
        redirect_to @problem, notice: 'Problem was successfully created.'
      else
        render :new
      end
  end


  def update
      if @problem.update(problem_params)
        redirect_to @problem, notice: 'Problem was successfully updated.'
      else
        render :edit
      end
  end


  def destroy
    @problem.destroy
      redirect_to problems_url, notice: 'Problem was successfully destroyed.'
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
    def set_problem
      @problem = Problem.find(params[:id])
    end

    def problem_params
      params.require(:problem).permit(:title, :content, :status, :declare_winner, category_ids:[], categories_attributes:[:name])
    end

    def vote_params
      params.require(:vote).permit(:proposal_id)
    end
end
