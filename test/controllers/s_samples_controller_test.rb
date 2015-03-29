require 'test_helper'

class SSamplesControllerTest < ActionController::TestCase
  setup do
    @s_sample = s_samples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_sample" do
    assert_difference('SSample.count') do
      post :create, s_sample: { deviceID: @s_sample.deviceID, hmu1s: @s_sample.hmu1s, hmu2s: @s_sample.hmu2s, ipaddr: @s_sample.ipaddr, lmrv1: @s_sample.lmrv1, lmrv2: @s_sample.lmrv2, numoflinks: @s_sample.numoflinks, oid: @s_sample.oid, rss2: @s_sample.rss2, rssi1: @s_sample.rssi1, s10: @s_sample.s10, s1: @s_sample.s1, s2: @s_sample.s2, s3: @s_sample.s3, s4: @s_sample.s4, s5: @s_sample.s5, s6: @s_sample.s6, s7: @s_sample.s7, s8: @s_sample.s8, s9: @s_sample.s9 }
    end

    assert_redirected_to s_sample_path(assigns(:s_sample))
  end

  test "should show s_sample" do
    get :show, id: @s_sample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_sample
    assert_response :success
  end

  test "should update s_sample" do
    patch :update, id: @s_sample, s_sample: { deviceID: @s_sample.deviceID, hmu1s: @s_sample.hmu1s, hmu2s: @s_sample.hmu2s, ipaddr: @s_sample.ipaddr, lmrv1: @s_sample.lmrv1, lmrv2: @s_sample.lmrv2, numoflinks: @s_sample.numoflinks, oid: @s_sample.oid, rss2: @s_sample.rss2, rssi1: @s_sample.rssi1, s10: @s_sample.s10, s1: @s_sample.s1, s2: @s_sample.s2, s3: @s_sample.s3, s4: @s_sample.s4, s5: @s_sample.s5, s6: @s_sample.s6, s7: @s_sample.s7, s8: @s_sample.s8, s9: @s_sample.s9 }
    assert_redirected_to s_sample_path(assigns(:s_sample))
  end

  test "should destroy s_sample" do
    assert_difference('SSample.count', -1) do
      delete :destroy, id: @s_sample
    end

    assert_redirected_to s_samples_path
  end
end
