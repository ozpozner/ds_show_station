require 'test_helper'

class BannerControllerTest < ActionController::TestCase
  test "should get rss" do
    get :rss
    assert_response :success
  end

end
