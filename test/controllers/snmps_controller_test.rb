require 'test_helper'

class SnmpsControllerTest < ActionController::TestCase
  setup do
    @snmp = snmps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snmps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snmp" do
    assert_difference('Snmp.count') do
      post :create, snmp: { deviceID: @snmp.deviceID, hmu1s: @snmp.hmu1s, hmu2s: @snmp.hmu2s, ipaddr: @snmp.ipaddr, lmrv1: @snmp.lmrv1, lmrv2: @snmp.lmrv2, numoflinks: @snmp.numoflinks, oid: @snmp.oid, rss2: @snmp.rss2, rssi1: @snmp.rssi1, s10: @snmp.s10, s1: @snmp.s1, s2: @snmp.s2, s3: @snmp.s3, s4: @snmp.s4, s5: @snmp.s5, s6: @snmp.s6, s7: @snmp.s7, s8: @snmp.s8, s9: @snmp.s9 }
    end

    assert_redirected_to snmp_path(assigns(:snmp))
  end

  test "should show snmp" do
    get :show, id: @snmp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snmp
    assert_response :success
  end

  test "should update snmp" do
    patch :update, id: @snmp, snmp: { deviceID: @snmp.deviceID, hmu1s: @snmp.hmu1s, hmu2s: @snmp.hmu2s, ipaddr: @snmp.ipaddr, lmrv1: @snmp.lmrv1, lmrv2: @snmp.lmrv2, numoflinks: @snmp.numoflinks, oid: @snmp.oid, rss2: @snmp.rss2, rssi1: @snmp.rssi1, s10: @snmp.s10, s1: @snmp.s1, s2: @snmp.s2, s3: @snmp.s3, s4: @snmp.s4, s5: @snmp.s5, s6: @snmp.s6, s7: @snmp.s7, s8: @snmp.s8, s9: @snmp.s9 }
    assert_redirected_to snmp_path(assigns(:snmp))
  end

  test "should destroy snmp" do
    assert_difference('Snmp.count', -1) do
      delete :destroy, id: @snmp
    end

    assert_redirected_to snmps_path
  end
end
