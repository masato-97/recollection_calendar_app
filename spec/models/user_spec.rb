require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "emailが被る場合にバリデーションエラーが起きるか" do
      user = create(:user)
      new_user = build(:user, email: user.email)
      expect(new_user).to be_invalid
      expect(new_user.errors[:email]).to include("はすでに存在します")
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
