require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  include LoginMacros

  describe 'ログイン前' do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常の場合" do
        it "ユーザーの新規登録が成功する" do
          visit new_user_registration_path
          fill_in "名前", with: "レコルディ"
          fill_in "メールアドレス", with: "user@example.com"
          fill_in "パスワード", with: "password"
          fill_in "パスワード（確認用）", with: "password"
          click_on "登録"
          expect(current_path).to eq memories_path
        end
      end

      context "フォームが未入力場合" do
        it "ユーザーの新規登録が失敗する" do
          visit new_user_registration_path
          fill_in "名前", with: ""
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: ""
          fill_in "パスワード（確認用）", with: ""
          click_on "登録"
          expect(page).to have_content "名前を入力してください"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(page).to have_content "パスワードを入力してください"
        end
      end

      context "登録済みのメールアドレスを入力した場合" do
        it "ユーザーの新規登録が失敗する" do
          replicate_user = create(:user)
          visit new_user_registration_path
          fill_in "名前", with: "レコルディ"
          fill_in "メールアドレス", with: replicate_user.email
          fill_in "パスワード", with: "password"
          fill_in "パスワード（確認用）", with: "password"
          click_on "登録"
          expect(page).to have_content "メールアドレスはすでに存在します"
        end
      end
    end

    describe "プロフィールページ遷移" do
      context "ログインしていない状態でプロフィールページに遷移した場合" do
        it "プロフィールページへのアクセスが失敗する" do
          visit users_profile_path
          expect(current_path).to eq root_path
        end
      end
    end

    describe "設定・その他ページ遷移" do
      context "ログインしていない状態で設定・その他ページに遷移した場合" do
        it "設定・その他ページへのアクセスが失敗する" do
          visit users_setting_path
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    describe "ユーザー編集" do
      context "フォームの入力値が正常の場合" do
        it "ユーザーの編集が成功する" do
          visit edit_user_registration_path
          fill_in "名前", with: "レコルディ"
          click_on "更新"
          expect(current_path).to eq users_profile_path
          expect(page).to have_content "アカウント情報を変更しました。"
        end
      end

      context "名前が未入力の場合" do
        it "ユーザーの編集が失敗する" do
          visit edit_user_registration_path
          fill_in "名前", with: ""
          click_on "更新"
          expect(page).to have_content "名前を入力してください"
        end
      end
    end

    describe "プロフィールページ遷移" do
      context "ポストを作成した場合" do
        it "プロフィールと作成したポストが表示される" do
          memory = create(:memory, user: user)
          create(:post, title: "title", body: "body", user: user, memory: memory)
          visit users_profile_path
          expect(page).to have_content "プロフィール"
          expect(page).to have_content user.name
          expect(page).to have_content user.email
          expect(page).to have_link("プロフィールを編集")
          expect(page).to have_content "title"
          expect(page).to have_content "body"
          expect(page).to have_link("ポスト詳細")
        end
      end
    end

    describe "設定・その他ページ遷移" do
      context "設定・その他ページに遷移した場合" do
        it "設定とその他の情報が表示される" do
          visit users_setting_path
          expect(page).to have_content "設定・その他"
          expect(page).to have_content "リマインダーメール"
          expect(page).to have_content "土曜日に休日通知メールを受け取る"
          expect(page).to have_content "日曜日に休日通知メールを受け取る"
          expect(page).to have_link("リマインダーメール設定")
          expect(page).to have_content "ヘルプ"
          expect(page).to have_link("Recordiの使い方")
          expect(page).to have_link("お問い合わせ")
          expect(page).to have_link("プライバシー")
          expect(page).to have_link("利用規約")
        end
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
