require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    user = User.create!(name: "テストユーザー", email: "test@example.com", password: "password")
    puts user.persisted?
    memory = user.memories.create!(title: "テストメモリー", body: "テストメモリー", day: "2025-03-25")
    sign_in user

    get user_url(user)
    assert_response :success
  end
end
