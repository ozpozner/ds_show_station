class MyroutesController < ApplicationController
  before_action :set_myroute, only: [:show, :edit, :update, :destroy]

  # GET /myroutes
  # GET /myroutes.json
  def index
    @myroutes = Myroute.all
  end

  # GET /myroutes/1
  # GET /myroutes/1.json
  def show
  end

  # GET /myroutes/new
  def new
    @myroute = Myroute.new
  end

  # GET /myroutes/1/edit
  def edit
  end

  # POST /myroutes
  # POST /myroutes.json
  def create
    @myroute = Myroute.new(myroute_params)

    respond_to do |format|
      if @myroute.save
        format.html { redirect_to @myroute, notice: 'Myroute was successfully created.' }
        format.json { render :show, status: :created, location: @myroute }
      else
        format.html { render :new }
        format.json { render json: @myroute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /myroutes/1
  # PATCH/PUT /myroutes/1.json
  def update
    respond_to do |format|
      if @myroute.update(myroute_params)
        format.html { redirect_to @myroute, notice: 'Myroute was successfully updated.' }
        format.json { render :show, status: :ok, location: @myroute }
      else
        format.html { render :edit }
        format.json { render json: @myroute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myroutes/1
  # DELETE /myroutes/1.json
  def destroy
    @myroute.destroy
    respond_to do |format|
      format.html { redirect_to myroutes_url, notice: 'Myroute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myroute
      @myroute = Myroute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def myroute_params
      params.require(:myroute).permit(:name, :routeId, :deviceId, :nextDeviceId, :prevDeviceId)
    end
end
