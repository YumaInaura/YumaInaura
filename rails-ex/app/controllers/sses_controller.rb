class SsesController < ApplicationController
  before_action :set_ss, only: %i[ show edit update destroy ]

  # GET /sses or /sses.json
  def index
    @sses = Ss.all
  end

  # GET /sses/1 or /sses/1.json
  def show
  end

  # GET /sses/new
  def new
    @ss = Ss.new
  end

  # GET /sses/1/edit
  def edit
  end

  # POST /sses or /sses.json
  def create
    @ss = Ss.new(ss_params)

    respond_to do |format|
      if @ss.save
        format.html { redirect_to ss_url(@ss), notice: "Ss was successfully created." }
        format.json { render :show, status: :created, location: @ss }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sses/1 or /sses/1.json
  def update
    respond_to do |format|
      if @ss.update(ss_params)
        format.html { redirect_to ss_url(@ss), notice: "Ss was successfully updated." }
        format.json { render :show, status: :ok, location: @ss }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sses/1 or /sses/1.json
  def destroy
    @ss.destroy

    respond_to do |format|
      format.html { redirect_to sses_url, notice: "Ss was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ss
      @ss = Ss.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ss_params
      params.fetch(:ss, {})
    end
end
