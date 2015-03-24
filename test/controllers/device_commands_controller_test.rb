require 'test_helper'

class DeviceCommandsControllerTest < ActionController::TestCase
  setup do
    @device_command = device_commands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_commands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_command" do
    assert_difference('DeviceCommand.count') do
      post :create, device_command: { command: @device_command.command, commandId: @device_command.commandId, deviceType: @device_command.deviceType, numOfR: @device_command.numOfR }
    end

    assert_redirected_to device_command_path(assigns(:device_command))
  end

  test "should show device_command" do
    get :show, id: @device_command
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_command
    assert_response :success
  end

  test "should update device_command" do
    patch :update, id: @device_command, device_command: { command: @device_command.command, commandId: @device_command.commandId, deviceType: @device_command.deviceType, numOfR: @device_command.numOfR }
    assert_redirected_to device_command_path(assigns(:device_command))
  end

  test "should destroy device_command" do
    assert_difference('DeviceCommand.count', -1) do
      delete :destroy, id: @device_command
    end

    assert_redirected_to device_commands_path
  end
end
