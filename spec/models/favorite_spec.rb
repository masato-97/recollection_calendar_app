require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "バリデーションチェック" do
    it "同じuser_idとpost_idの組み合わせは一意であること" do
      user = create(:user)
      memory = create(:memory, user: user)
      post = create(:post, user: user, memory: memory)
      create(:favorite, user: user, post: post)

      duplicate = build(:favorite, user: user, post: post)
      expect(duplicate).to be_invalid
      expect(duplicate.errors[:user_id]).to include("はすでに存在します")
    end

    it "異なるuser_idであれば同じpost_idをお気に入り登録できること" do
      user1 = create(:user)
      user2 = create(:user)
      memory = create(:memory, user: user1)
      post = create(:post, user: user1, memory: memory)
      create(:favorite, user: user1, post: post)

      another = build(:favorite, user: user2, post: post)
      expect(another).to be_valid
      expect(another.errors).to be_empty
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
