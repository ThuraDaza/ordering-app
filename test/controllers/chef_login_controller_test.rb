require "test_helper"

class ChefLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get chef_login_login_url
    assert_response :success
  end
end
