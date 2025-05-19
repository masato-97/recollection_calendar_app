require 'rails_helper'

RSpec.describe MiddlePostTag, type: :model do
  describe "バリデーション" do
    it "同じpost_idとpost_tag_idの組み合わせは無効であること" do
      user = create(:user)
      memory = create(:memory, user: user)
      post = create(:post, user: user, memory: memory)
      tag = create(:post_tag)
      create(:middle_post_tag, post: post, post_tag: tag)

      duplicate = build(:middle_post_tag, post: post, post_tag: tag)
      expect(duplicate).to be_invalid
      expect(duplicate.errors[:post_tag_id]).to include("はすでに存在します")
    end

    it "異なるpost_idであれば同じpost_tag_idでも有効であること" do
      user = create(:user)
      memory1 = create(:memory, user: user)
      memory2 = create(:memory, user: user)
      tag = create(:post_tag)
      create(:middle_post_tag, post: create(:post, user: user, memory: memory1), post_tag: tag)

      new_record = build(:middle_post_tag, post: create(:post, user: user, memory: memory2), post_tag: tag)
      expect(new_record).to be_valid
      expect(new_record.errors).to be_empty
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
