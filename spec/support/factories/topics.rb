FactoryGirl.define do
  factory :topic do
    sequence(:name) { |n| "topic name #{n}" }
    description "some description"
    association :user
    association :event
  end
end
