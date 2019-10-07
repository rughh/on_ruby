# frozen_string_literal: true

FactoryBot.define do
  factory :material do
    event
    user
    topic
    name { Faker::Lorem.words(number: 5).join }
    url { Faker::Internet.url }
  end
end
