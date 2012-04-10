FactoryGirl.define do
  factory :event do
    name "Weihnachtstreffen"
    date "2010-12-06 11:47:30"
    description "MyText"
    association :location
    association :user
    created_at "2010-12-06 11:47:30"
    updated_at "2010-12-06 11:47:30"
  end
end
