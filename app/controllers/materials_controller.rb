class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]


  def index
    if params[:proposal_id]
        set_proposal
        set_problem
        @materials = @proposal.materials
      else
        @materials = Material.all
      end
  end


  def show
    set_material
    if params[:proposal_id]
      set_proposal
      set_problem
    end
  end

  def new
    if params[:proposal_id]
      set_proposal
      @material = @proposal.materials.build
    else
      @material = Material.new
    end

  end

  def edit
    if params[:problem_id]
      set_problem
      set_proposal
      set_material
    else
      set_proposal
    end
  end


  def create
    if params[:proposal_id]
      set_proposal
      @material = @proposal.materials.build(materical_params)
  else
      @material = Material.new(material_params)
  end
      if @material.save
        redirect_to @material, notice: 'Material was successfully created.'
      else
        render :new
      end
  end


  def update
      if @material.update(material_params)
      redirect_to @material, notice: 'Material was successfully updated.'
      else
        render :edit
      end
  end


  def destroy
    @material.destroy
      redirect_to materials_url, notice: 'Material was successfully destroyed.'
  end

  private
    def set_material
      @material = Material.find(params[:id])
    end

    def material_params
      params.require(:material).permit(:name, :quantity)
    end

    def set_proposal
      @proposal = Proposal.find_by_id(params[:proposal_id])
    end

    def set_problem
      @problem = Problem.find_by_id(params[:problem_id])
    end
end
