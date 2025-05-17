require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      memory = build(:memory, user: user)
      post = build(:post, user: user, memory: memory)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end

    it "titleが256文字以上の場合は登録できない" do
      user = build(:user)
      memory = build(:memory, user: user)
      post = build(:post, title: "a" * 256, user: user, memory: memory)
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("は255文字以内で入力してください")
    end

    it "bodyが65,536文字以上の場合は登録できない" do
      user = build(:user)
      memory = build(:memory, user: user)
      post = build(:post, body: "a" * 65536, user: user, memory: memory)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("は65535文字以内で入力してください")
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
