require 'rails_helper'

RSpec.describe "Memories", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:memory) { create(:memory, user: user) }
  include LoginMacros

  describe "ログイン前" do
    describe "ページ遷移確認" do
      context "カレンダーページにアクセスした場合" do
        it "カレンダーページへのアクセスが失敗する" do
          visit memories_path
          expect(current_path).to eq root_path
        end
      end

      context "思い出一覧ページにアクセスした場合" do
        it "思い出一覧ページへのアクセスが失敗する" do
          visit all_memories_path
          expect(current_path).to eq root_path
        end
      end

      context "思い出記録ページにアクセスした場合" do
        it "思い出記録ページへのアクセスが失敗する" do
          visit new_memory_path
          expect(current_path).to eq root_path
        end
      end

      context "思い出詳細ページにアクセスした場合" do
        it "思い出詳細ページへのアクセスが失敗する" do
          visit memory_path(memory)
          expect(current_path).to eq root_path
        end
      end

      context "思い出編集ページにアクセスした場合" do
        it "思い出編集ページへのアクセスが失敗する" do
          visit edit_memory_path(memory)
          expect(current_path).to eq root_path
        end
      end

      context "思い出の数比較ページにアクセスした場合" do
        it "思い出の数比較ページへのアクセスが失敗する" do
          visit compare_memories_path
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    describe "カレンダーページ" do
      context "カレンダーページにアクセスした場合" do
        it "カレンダーが表示される" do
          visit memories_path
          expect(page).to have_link("<<")
          expect(page).to have_content "#{Date.today.strftime("%Y年")}"
          expect(page).to have_link(">>")
          expect(page).to have_link("今日")
          expect(page).to have_content "日"
          expect(page).to have_content "月"
          expect(page).to have_content "火"
          expect(page).to have_content "水"
          expect(page).to have_content "木"
          expect(page).to have_content "金"
          expect(page).to have_content "土"
          (1..28).each do |number|
            expect(page).to have_content "#{number}"
          end
          expect(page).to have_content "思い出の数：0"
        end
      end

      context "思い出を１つ記録し、カレンダーページにアクセスした場合" do
        it "カレンダーが表示され、思い出の数が１になる" do
          create(:memory, user: user)
          visit memories_path
          expect(page).to have_link("<<")
          expect(page).to have_content "#{Date.today.strftime("%Y年")}"
          expect(page).to have_link(">>")
          expect(page).to have_link("今日")
          expect(page).to have_content "日"
          expect(page).to have_content "月"
          expect(page).to have_content "火"
          expect(page).to have_content "水"
          expect(page).to have_content "木"
          expect(page).to have_content "金"
          expect(page).to have_content "土"
          (1..28).each do |number|
            expect(page).to have_content "#{number}"
          end
          expect(page).to have_content "思い出の数：1"
        end
      end
    end

    describe "思い出一覧" do
      context "思い出を１つ記録し、思い出一覧ページにアクセスした場合" do
        it "思い出が表示される" do
          create(:memory, user: user)
          visit all_memories_path
          expect(page).to have_content "思い出一覧"
          expect(page).to have_link("７ヶ月間の思い出の数を比較")
          expect(page).to have_content memory.title
          expect(page).to have_content memory.body
          expect(page).to have_content memory.day.strftime("%Y/%m/%d")
          expect(page).to have_link("思い出詳細")
        end
      end

      context "思い出を記録しないで、思い出一覧ページにアクセスした場合" do
        it "思い出は表示されない" do
          visit all_memories_path
          expect(page).to have_content "思い出一覧"
          expect(page).to have_link("７ヶ月間の思い出の数を比較")
          expect(page).to have_content "思い出がありません"
        end
      end
    end

    describe "思い出記録" do
      context "フォームの必須項目の入力値が正常の場合" do
        it "思い出の記録に成功する" do
          visit new_memory_path
          fill_in "日付", with: "2025-01-01"
          fill_in "タイトル", with: "title_test"
          fill_in "本文", with: "body_test"
          click_button "登録"
          memory = Memory.last
          expect(current_path).to eq memory_path(memory)
          expect(page).to have_content "思い出を記録しました"
          expect(page).to have_content "2025-01-01"
          expect(page).to have_content "title_test"
          expect(page).to have_content "body_test"
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_content "※評価を登録すると、この思い出をポストとして他のユーザーに共有することができます。"
          expect(page).to have_link("思い出一覧")
        end
      end

      context 'フォームが未入力の場合' do
        it '思い出の記録に失敗する' do
          visit new_memory_path
          fill_in "日付", with: ""
          fill_in "タイトル", with: ""
          fill_in "本文", with: ""
          click_button "登録"
          expect(page).to have_content "思い出を記録出来ませんでした"
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "本文を入力してください"
          expect(page).to have_content "日付を入力してください"
        end
      end
    end

    describe "思い出詳細" do
      context "必須項目のみ記録した思い出の詳細ページにアクセスした場合" do
        it "思い出が表示される" do
          visit memory_path(memory)
          expect(page).to have_content memory.day
          expect(page).to have_content memory.title
          expect(page).to have_content memory.body
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_content "※評価を登録すると、この思い出をポストとして他のユーザーに共有することができます。"
          expect(page).to have_link("思い出一覧")
        end
      end

      context "必須項目と評価を記録した思い出の詳細ページにアクセスした場合" do
        it "思い出が表示される" do
          memory = create(:memory, score: "5", user: user)
          visit memory_path(memory)
          expect(page).to have_content memory.day
          expect(page).to have_content memory.title
          expect(page).to have_content memory.body
          expect(page).to have_content memory.score
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_link("ポストを作成")
          expect(page).to have_content "※ポストを作成すると、この思い出を他のユーザーに共有することができます。"
          expect(page).to have_link("思い出一覧")
        end
      end

      context "ポストを作成済みの思い出の詳細ページにアクセスした場合" do
        it "思い出が表示される" do
          memory = create(:memory, score: "5", user: user)
          create(:post, user: user, memory: memory)
          visit memory_path(memory)
          expect(page).to have_content memory.day
          expect(page).to have_content memory.title
          expect(page).to have_content memory.body
          expect(page).to have_content memory.score
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_link("ポスト詳細")
          expect(page).to have_link("思い出一覧")
        end
      end
    end

    describe "思い出編集" do
      context "フォームの必須項目の入力値が正常の場合" do
        it "思い出の編集に成功する" do
          visit edit_memory_path(memory)
          fill_in "日付", with: "2025-01-02"
          fill_in "タイトル", with: "updated_title"
          fill_in "本文", with: "updated_body"
          click_button "更新"
          expect(current_path).to eq memory_path(memory)
          expect(page).to have_content "思い出を更新しました"
          expect(page).to have_content "2025-01-02"
          expect(page).to have_content "updated_title"
          expect(page).to have_content "updated_body"
          expect(page).to have_link("編集")
          expect(page).to have_link("削除")
          expect(page).to have_link("思い出一覧")
        end
      end

      context "フォームの必須項目が未入力の場合" do
        it "思い出の編集に失敗する" do
          visit edit_memory_path(memory)
          fill_in "日付", with: ""
          fill_in "タイトル", with: ""
          fill_in "本文", with: ""
          click_button "更新"
          expect(page).to have_content "思い出を更新出来ませんでした"
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "本文を入力してください"
          expect(page).to have_content "日付を入力してください"
        end
      end
    end

    describe "思い出の削除" do
      context "思い出を削除する場合" do
        it "思い出の削除に成功する", js: true  do
          visit memory_path(memory)
          click_link "削除"
          expect(current_path).to eq all_memories_path
          expect(page).to have_content "思い出を削除しました"
          expect(page).not_to have_content memory.title
          expect(page).not_to have_content memory.body
          expect(page).not_to have_content memory.day
        end
      end
    end

    describe "思い出の数比較" do
      context "思い出の数比較ページにアクセスした場合" do
        it "思い出の数を比較するグラフが表示される" do
          visit compare_memories_path
          expect(page).to have_content "7ヶ月間の思い出の数"
          expect(page).to have_content "記録した思い出の数"
          expect(page).to have_content "今月"
          (1..6).each do |number|
            expect(page).to have_content "#{number}ヶ月前"
          end
          expect(page).to have_link("思い出一覧")
        end
      end
    end
  end

  pending "add some scenarios (or delete) #{__FILE__}"
end
