FactoryGirl.define do
  factory :event do
    name        { Faker::Lorem.words(6).join }
    date        { rand(3).days.from_now }
    description { Faker::Lorem.sentences(3).join }
    association :location
    association :user
    created_at  { Time.now }
  end

  factory :event_with_participants, parent: :event do |event|
    after(:create) { |event| FactoryGirl.create(:participant, event: event) }
  end
end
