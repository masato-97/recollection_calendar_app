require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = User.create(name: "テストユーザー", email: "test@example.com")
    Memory.create(title: "テストのタイトル", body: "テストのボディ", user_id: user.id)
    get user_url(user)
    assert_response :success
  end
end
