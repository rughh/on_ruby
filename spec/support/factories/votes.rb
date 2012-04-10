FactoryGirl.define do
  factory :vote do
    association :wish
    association :user
    count 5
    comment "MyText"
  end
end
