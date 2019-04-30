FactoryBot.define do
  factory :material do
    event
    user
    topic
    name { Faker::Lorem.words(5).join }
    url { Faker::Internet.url }
  end
end
