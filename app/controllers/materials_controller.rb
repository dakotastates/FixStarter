class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index
    if params[:proposal_id]
        set_proposal
        set_problem
        @materials = @proposal.materials
      else
        @materials = Material.all
      end
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    set_material
    if params[:proposal_id]
      set_proposal
      set_problem
    end
  end

  # GET /materials/new
  def new
    if params[:proposal_id]
      set_proposal
      @material = @proposal.materials.build
    else
      @material = Material.new
    end

  end

  # GET /materials/1/edit
  def edit
    if params[:problem_id]
      set_problem
      set_proposal
      set_material
    else
      set_proposal
    end
  end

  # POST /materials
  # POST /materials.json
  def create
    if params[:proposal_id]
      set_proposal
      @material = @proposal.materials.build(materical_params)
  else
      @material = Material.new(material_params)
  end
    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to materials_url, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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
