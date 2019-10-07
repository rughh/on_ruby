# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    name { Faker::Name.name }
    url  { Faker::Internet.url }
    association :location, strategy: :build
  end
end
