require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "バリデーションチェック" do
    it "nameがあれば有効であること" do
      tag = build(:tag)
      expect(tag).to be_valid
      expect(tag.errors).to be_empty
    end

    it "nameがなければ無効であること" do
      tag = build(:tag, name: nil)
      expect(tag).to be_invalid
      expect(tag.errors[:name]).to include("を入力してください")
    end
  end

  describe "アソシエーションチェック" do
    it "middle_tagsとの関連があること" do
      expect(Tag.reflect_on_association(:middle_tags).macro).to eq(:has_many)
    end

    it "memoriesとの関連があること（through: middle_tags）" do
      association = Tag.reflect_on_association(:memories)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:middle_tags)
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
