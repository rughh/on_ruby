FactoryBot.define do
  factory :event do
    name        { Faker::Lorem.words(6).join }
    date        { rand(3).days.from_now }
    description { Faker::Lorem.sentences(3).join }
    association :location, strategy: :build
    association :user, strategy: :build
    created_at  { Time.now }
    updated_at  { Time.now }
  end

  factory :event_with_participants, parent: :event do
    after(:create) { |event| 3.times { create(:participant, event: event) } }
  end

  factory :full_event, parent: :event_with_participants do
    after(:create) { |event|
      event.participants  << create(:participant)
      event.materials     << create(:material)
      event.topics        << create(:topic)
    }
  end

  factory :closed_event, parent: :event do
    limit 0
  end
end
