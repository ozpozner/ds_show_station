require 'test_helper'

class MyroutesControllerTest < ActionController::TestCase
  setup do
    @myroute = myroutes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:myroutes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create myroute" do
    assert_difference('Myroute.count') do
      post :create, myroute: { deviceId: @myroute.deviceId, id: @myroute.id, name: @myroute.name, nextDeviceId: @myroute.nextDeviceId, prevDeviceId: @myroute.prevDeviceId }
    end

    assert_redirected_to myroute_path(assigns(:myroute))
  end

  test "should show myroute" do
    get :show, id: @myroute
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @myroute
    assert_response :success
  end

  test "should update myroute" do
    patch :update, id: @myroute, myroute: { deviceId: @myroute.deviceId, id: @myroute.id, name: @myroute.name, nextDeviceId: @myroute.nextDeviceId, prevDeviceId: @myroute.prevDeviceId }
    assert_redirected_to myroute_path(assigns(:myroute))
  end

  test "should destroy myroute" do
    assert_difference('Myroute.count', -1) do
      delete :destroy, id: @myroute
    end

    assert_redirected_to myroutes_path
  end
end
