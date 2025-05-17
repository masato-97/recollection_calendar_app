require 'rails_helper'

RSpec.describe Memory, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      memory = build(:memory, user: user)
      expect(memory).to be_valid
      expect(memory.errors).to be_empty
    end

    it "titleが256文字以上の場合は登録できない" do
      user = build(:user)
      memory = build(:memory, title: "a" * 256, user: user)
      expect(memory).to be_invalid
      expect(memory.errors[:title]).to include("は255文字以内で入力してください")
    end

    it "bodyが65,536文字以上の場合は登録できない" do
      user = build(:user)
      memory = build(:memory, body: "a" * 65536, user: user)
      expect(memory).to be_invalid
      expect(memory.errors[:body]).to include("は65535文字以内で入力してください")
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
