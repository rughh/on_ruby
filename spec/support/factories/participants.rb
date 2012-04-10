FactoryGirl.define do
  factory :participant do
    association :user, :factory => :user
    association :event, :factory => :event
    maybe false
    comment "MyText"
  end
end
