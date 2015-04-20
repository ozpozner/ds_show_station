require 'test_helper'

class CamEventsControllerTest < ActionController::TestCase
  setup do
    @cam_event = cam_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cam_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cam_event" do
    assert_difference('CamEvent.count') do
      post :create, cam_event: { acknowledged: @cam_event.acknowledged, acknowledged_at: @cam_event.acknowledged_at, eventTime: @cam_event.eventTime, eventType: @cam_event.eventType, source: @cam_event.source }
    end

    assert_redirected_to cam_event_path(assigns(:cam_event))
  end

  test "should show cam_event" do
    get :show, id: @cam_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cam_event
    assert_response :success
  end

  test "should update cam_event" do
    patch :update, id: @cam_event, cam_event: { acknowledged: @cam_event.acknowledged, acknowledged_at: @cam_event.acknowledged_at, eventTime: @cam_event.eventTime, eventType: @cam_event.eventType, source: @cam_event.source }
    assert_redirected_to cam_event_path(assigns(:cam_event))
  end

  test "should destroy cam_event" do
    assert_difference('CamEvent.count', -1) do
      delete :destroy, id: @cam_event
    end

    assert_redirected_to cam_events_path
  end
end
