FactoryBot.define do
  factory :inquiry do
    sequence(:email) { |n| "user-#{n}@recordi.jp" }
    subject { "subject" }
    message { "message" }
  end
end
