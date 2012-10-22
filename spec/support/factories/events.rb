FactoryGirl.define do
  factory :event do
    sequence(:name){ |n| "Weihnachtstreffen #{2000 + n}" }
    date "2010-12-06 11:47:30"
    description "MyText"
    association :location
    association :user
    created_at "2010-12-06 11:47:30"
    updated_at "2010-12-06 11:47:30"
  end

  factory :event_with_participants, parent: :event do |event|
    after(:create) { |event| FactoryGirl.create(:participant, event: event) }
  end
end
