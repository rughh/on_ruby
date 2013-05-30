FactoryGirl.define do
  factory :topic do
    name        { Faker::Lorem.words(5).join }
    description { Faker::Lorem.sentences(3).join }
    association :user
    association :event
  end
end
