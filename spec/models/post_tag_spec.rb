require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe "バリデーションチェック" do
    it "nameがあれば有効であること" do
      post_tag = build(:post_tag)
      expect(post_tag).to be_valid
      expect(post_tag.errors).to be_empty
    end

    it "nameがなければ無効であること" do
      post_tag = build(:post_tag, name: nil)
      expect(post_tag).to be_invalid
      expect(post_tag.errors[:name]).to include("を入力してください")
    end
  end

  describe "アソシエーションチェック" do
    it "middle_post_tagsとの関連があること" do
      expect(PostTag.reflect_on_association(:middle_post_tags).macro).to eq(:has_many)
    end

    it "postsとの関連があること（through: middle_post_tags）" do
      association = PostTag.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:middle_post_tags)
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
