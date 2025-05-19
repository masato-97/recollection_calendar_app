require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      inquiry = build(:inquiry)
      expect(inquiry).to be_valid
      expect(inquiry.errors).to be_empty
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
