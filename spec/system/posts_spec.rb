require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:memory) { create(:memory, score: "5", user: user) }
  let!(:post) { create(:post, user: user, memory: memory) }
  include LoginMacros

  describe "ログイン前" do
    describe "ページ遷移確認" do
      context "ポスト一覧ページにアクセスした場合" do
        it "ポスト一覧ページへのアクセスが失敗する" do
          visit posts_path
          expect(current_path).to eq root_path
        end
      end

      context "ポスト作成ページにアクセスした場合" do
        it "ポスト作成ページへのアクセスが失敗する" do
          visit new_memory_post_path(memory)
          expect(current_path).to eq root_path
        end
      end

      context "ポスト詳細ページにアクセスした場合" do
        it "ポスト詳細ページへのアクセスが失敗する" do
          visit memory_post_path(memory, memory.post)
          expect(current_path).to eq root_path
        end
      end

      context "ポスト編集ページにアクセスした場合" do
        it "ポスト編集ページへのアクセスが失敗する" do
          visit edit_memory_post_path(memory, memory.post)
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    describe "ポスト一覧" do
      context "ポストを作成して、ポスト一覧ページにアクセスした場合" do
        it "作成したポストが表示される" do
          visit posts_path
          expect(page).to have_content "ポスト一覧"
          expect(page).to have_content user.name
          expect(page).to have_content memory.score
          expect(page).to have_content post.title
          expect(page).to have_content post.body
          expect(page).to have_content post.created_at.strftime("%Y/%m/%d")
          expect(page).to have_link("ポスト詳細")
        end
      end
    end

    describe "ポスト詳細" do
      context "自分で作成したポストの詳細ページにアクセスした場合" do
        it "ポストが表示される" do
          visit memory_post_path(memory, memory.post)
          expect(page).to have_content user.name
          expect(page).to have_content post.title
          expect(page).to have_content post.body
          expect(page).to have_content memory.score
          expect(page).to have_content post.created_at.strftime("%Y/%m/%d")
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_link("ポスト一覧")
          expect(page).to have_link("自分のポスト一覧")
          expect(page).to have_link("このポストの思い出詳細")
        end
      end

      context "他のユーザーのポストの詳細ページにアクセスした場合" do
        it "ポストが表示される" do
          other_user = create(:user)
          other_user_mamory = create(:memory, score: "5", user: other_user)
          other_user_post = create(:post, user: other_user, memory: other_user_mamory)
          visit memory_post_path(other_user_mamory, other_user_mamory.post)
          expect(page).to have_content other_user.name
          expect(page).to have_content other_user_post.title
          expect(page).to have_content other_user_post.body
          expect(page).to have_content other_user_mamory.score
          expect(page).to have_content other_user_post.created_at.strftime("%Y/%m/%d")
          expect(page).to have_link("ポスト一覧")
        end
      end
    end

    describe "ポスト編集" do
      context "フォームの必須項目の入力値が正常の場合" do
        it "ポストの編集に成功する" do
          visit edit_memory_post_path(memory, memory.post)
          fill_in "タイトル", with: "updated_title"
          fill_in "本文", with: "updated_body"
          click_button "更新"
          expect(current_path).to eq memory_post_path(memory, memory.post)
          expect(page).to have_content "ポストを更新しました"
          expect(page).to have_content user.name
          expect(page).to have_content "updated_title"
          expect(page).to have_content "updated_body"
          expect(page).to have_content memory.score
          expect(page).to have_content post.created_at.strftime("%Y/%m/%d")
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_link("ポスト一覧")
          expect(page).to have_link("自分のポスト一覧")
          expect(page).to have_link("このポストの思い出詳細")
        end
      end

      context "フォームの必須項目が未入力の場合" do
        it "ポストの編集に失敗する" do
          visit edit_memory_post_path(memory, memory.post)
          fill_in "タイトル", with: ""
          fill_in "本文", with: ""
          click_button "更新"
          expect(page).to have_content "ポストを更新出来ませんでした"
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "本文を入力してください"
        end
      end
    end

    describe "思い出の削除" do
      context "思い出を削除する場合" do
        it "思い出の削除に成功する", js: true  do
          visit memory_post_path(memory, memory.post)
          click_link "削除"
          expect(current_path).to eq posts_path
          expect(page).to have_content "ポストを削除しました"
          expect(page).not_to have_content post.title
          expect(page).not_to have_content post.body
          expect(page).not_to have_content post.created_at.strftime("%Y/%m/%d")
        end
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
