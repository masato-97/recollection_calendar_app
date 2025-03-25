require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    user = User.create!(name: "テストユーザー", email: "test@example.com", password: "password")
    memory = user.memories.create!(title: "テストメモリー", body: "テストメモリー", day: "2025-03-25") # Memory を明示的に作成
    sign_in user # current_user を設定

    get user_url(user) # 適切なルートに変更
    assert_response :success
  end
end
