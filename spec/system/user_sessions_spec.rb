require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  include LoginMacros

  describe "ログイン前" do
    context "フォームの入力値が正常の場合" do
      it "ログイン処理が成功する" do
        expect(user).to be_valid
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(current_path).to eq memories_path
      end
    end

    context "フォームが未入力場合" do
      it "ログイン処理が失敗する" do
        visit new_user_session_path
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
