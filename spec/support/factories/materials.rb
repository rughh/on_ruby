FactoryBot.define do
  factory :material do
    name        { Faker::Lorem.words(5).join }
    url         { Faker::Internet.url }
    association :event, strategy: :build
  end
end
