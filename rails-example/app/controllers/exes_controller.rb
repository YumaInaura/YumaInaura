class ExesController < ApplicationController
  before_action :set_ex, only: %i[ show edit update destroy ]

  # GET /exes or /exes.json
  def index
    @exes = Ex.all
  end

  # GET /exes/1 or /exes/1.json
  def show
    render "exes/show.jb"
  end

  # GET /exes/new
  def new
    @ex = Ex.new
  end

  # GET /exes/1/edit
  def edit
  end

  # POST /exes or /exes.json
  def create
    @ex = Ex.new(ex_params)

    respond_to do |format|
      if @ex.save
        format.html { redirect_to ex_url(@ex), notice: "Ex was successfully created." }
        format.json { render :show, status: :created, location: @ex }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exes/1 or /exes/1.json
  def update
    respond_to do |format|
      if @ex.update(ex_params)
        format.html { redirect_to ex_url(@ex), notice: "Ex was successfully updated." }
        format.json { render :show, status: :ok, location: @ex }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exes/1 or /exes/1.json
  def destroy
    @ex.destroy

    respond_to do |format|
      format.html { redirect_to exes_url, notice: "Ex was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ex
      @ex = Ex.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ex_params
      params.require(:ex).permit(:message)
    end
end
