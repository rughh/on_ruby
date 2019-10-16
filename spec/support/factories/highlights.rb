FactoryBot.define do
  factory :highlight do
    description { Faker::Lorem.words(number: 6).join }
    url         { Faker::Internet.url }
    start_at    { Date.tomorrow }
    end_at      { rand(5).days.from_now }
  end
end
