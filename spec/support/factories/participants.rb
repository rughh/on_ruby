FactoryGirl.define do
  factory :participant do
    association :user
    association :event
  end
end
