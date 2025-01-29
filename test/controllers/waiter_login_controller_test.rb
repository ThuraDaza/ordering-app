require "test_helper"

class WaiterLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get waiter_login_login_url
    assert_response :success
  end
end
