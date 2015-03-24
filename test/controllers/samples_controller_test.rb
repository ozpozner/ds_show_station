require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  setup do
    @sample = samples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sample" do
    assert_difference('Sample.count') do
      post :create, sample: { currentHBS: @sample.currentHBS, hmu1: @sample.hmu1, hmu1_DATA: @sample.hmu1_DATA, hmu1_HBS: @sample.hmu1_HBS, hmu1_RSSI: @sample.hmu1_RSSI, hmu2: @sample.hmu2, hmu2_DATA: @sample.hmu2_DATA, hmu2_HBS: @sample.hmu2_HBS, hmu2_RSSI: @sample.hmu2_RSSI, nextHBS: @sample.nextHBS, prevHBS: @sample.prevHBS, routeId: @sample.routeId }
    end

    assert_redirected_to sample_path(assigns(:sample))
  end

  test "should show sample" do
    get :show, id: @sample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sample
    assert_response :success
  end

  test "should update sample" do
    patch :update, id: @sample, sample: { currentHBS: @sample.currentHBS, hmu1: @sample.hmu1, hmu1_DATA: @sample.hmu1_DATA, hmu1_HBS: @sample.hmu1_HBS, hmu1_RSSI: @sample.hmu1_RSSI, hmu2: @sample.hmu2, hmu2_DATA: @sample.hmu2_DATA, hmu2_HBS: @sample.hmu2_HBS, hmu2_RSSI: @sample.hmu2_RSSI, nextHBS: @sample.nextHBS, prevHBS: @sample.prevHBS, routeId: @sample.routeId }
    assert_redirected_to sample_path(assigns(:sample))
  end

  test "should destroy sample" do
    assert_difference('Sample.count', -1) do
      delete :destroy, id: @sample
    end

    assert_redirected_to samples_path
  end
end
