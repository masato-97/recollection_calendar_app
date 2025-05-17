require 'rails_helper'

RSpec.describe MiddleTag, type: :model do
  describe "バリデーションチェック" do
    it "同じmemory_idとtag_idの組み合わせは一意であること" do
      user = create(:user)
      memory = create(:memory, user: user)
      tag = create(:tag)
      create(:middle_tag, memory: memory, tag: tag)

      duplicate = build(:middle_tag, memory: memory, tag: tag)
      expect(duplicate).to be_invalid
      expect(duplicate.errors[:tag_id]).to include("はすでに存在します")
    end

    it "異なるmemory_idなら同じtag_idでも保存できること" do
      user = create(:user)
      memory = create(:memory, user: user)
      tag = create(:tag)
      create(:middle_tag, memory: create(:memory, user: user), tag: tag)

      another = build(:middle_tag, memory: create(:memory, user: user), tag: tag)
      expect(another).to be_valid
      expect(another.errors).to be_empty
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
