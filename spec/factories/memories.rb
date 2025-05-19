FactoryBot.define do
  factory :memory do
    day { Date.today }
    title { "title" }
    body { "body" }
  end
end
