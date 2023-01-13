class FoosController < ApplicationController
  before_action :set_foo, only: %i[ show edit update destroy ]

  # GET /foos or /foos.json
  def index
    @foos = Foo.all
  end

  # GET /foos/1 or /foos/1.json
  def show
  end

  # GET /foos/new
  def new
    @foo = Foo.new
  end

  # GET /foos/1/edit
  def edit
  end

  # POST /foos or /foos.json
  def create
    @foo = Foo.new(foo_params)

    respond_to do |format|
      if @foo.save
        format.html { redirect_to foo_url(@foo), notice: "Foo was successfully created." }
        format.json { render :show, status: :created, location: @foo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foos/1 or /foos/1.json
  def update
    respond_to do |format|
      if @foo.update(foo_params)
        format.html { redirect_to foo_url(@foo), notice: "Foo was successfully updated." }
        format.json { render :show, status: :ok, location: @foo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @foo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foos/1 or /foos/1.json
  def destroy
    @foo.destroy

    respond_to do |format|
      format.html { redirect_to foos_url, notice: "Foo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foo
      @foo = Foo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def foo_params
      params.fetch(:foo, {})
    end
end
