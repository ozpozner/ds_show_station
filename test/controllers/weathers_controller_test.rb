require 'test_helper'

class WeathersControllerTest < ActionController::TestCase
  setup do
    @weather = weathers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weathers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather" do
    assert_difference('Weather.count') do
      post :create, weather: { condText: @weather.condText, fordate: @weather.fordate, iconID: @weather.iconID, name: @weather.name, temp: @weather.temp, tempHigh: @weather.tempHigh, tempLow: @weather.tempLow, title: @weather.title, woeid: @weather.woeid }
    end

    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should show weather" do
    get :show, id: @weather
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather
    assert_response :success
  end

  test "should update weather" do
    patch :update, id: @weather, weather: { condText: @weather.condText, fordate: @weather.fordate, iconID: @weather.iconID, name: @weather.name, temp: @weather.temp, tempHigh: @weather.tempHigh, tempLow: @weather.tempLow, title: @weather.title, woeid: @weather.woeid }
    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should destroy weather" do
    assert_difference('Weather.count', -1) do
      delete :destroy, id: @weather
    end

    assert_redirected_to weathers_path
  end
end
