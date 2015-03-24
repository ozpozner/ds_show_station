class DeviceCommandsController < ApplicationController
  before_action :set_device_command, only: [:show, :edit, :update, :destroy]

  # GET /device_commands
  # GET /device_commands.json
  def index
    @device_commands = DeviceCommand.all
  end

  # GET /device_commands/1
  # GET /device_commands/1.json
  def show
  end

  # GET /device_commands/new
  def new
    @device_command = DeviceCommand.new
  end

  # GET /device_commands/1/edit
  def edit
  end

  # POST /device_commands
  # POST /device_commands.json
  def create
    @device_command = DeviceCommand.new(device_command_params)

    respond_to do |format|
      if @device_command.save
        format.html { redirect_to @device_command, notice: 'Device command was successfully created.' }
        format.json { render :show, status: :created, location: @device_command }
      else
        format.html { render :new }
        format.json { render json: @device_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_commands/1
  # PATCH/PUT /device_commands/1.json
  def update
    respond_to do |format|
      if @device_command.update(device_command_params)
        format.html { redirect_to @device_command, notice: 'Device command was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_command }
      else
        format.html { render :edit }
        format.json { render json: @device_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_commands/1
  # DELETE /device_commands/1.json
  def destroy
    @device_command.destroy
    respond_to do |format|
      format.html { redirect_to device_commands_url, notice: 'Device command was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_command
      @device_command = DeviceCommand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_command_params
      params.require(:device_command).permit(:deviceType, :command, :numOfR, :commandId)
    end
end
