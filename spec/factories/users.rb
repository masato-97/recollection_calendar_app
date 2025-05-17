FactoryBot.define do
  factory :user do
    name { "レコルディ" }
    sequence(:email) { |n| "user-#{n}@recordi.jp" }
    password { "password" }
  end
end
