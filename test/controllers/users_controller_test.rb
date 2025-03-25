require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = User.create(name: "テストユーザー", email: "test@example.com")
    get user_url(user)
    assert_response :success
  end
end
