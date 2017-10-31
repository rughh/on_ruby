FactoryBot.define do
  factory :event do
    name        { Faker::Lorem.words(6).join }
    date        { rand(3).days.from_now }
    description { Faker::Lorem.sentences(3).join }
    association :location
    association :user
    created_at  { Time.now }
    updated_at  { Time.now }
  end

  factory :event_with_participants, parent: :event do |_event|
    after(:create) { |e| 3.times { FactoryBot.create(:participant, event: e) } }
  end

  factory :full_event, parent: :event_with_participants do |_event|
    after(:create) { |e|
      e.participants  << FactoryBot.create(:participant)
      e.materials     << FactoryBot.create(:material)
      e.topics        << FactoryBot.create(:topic)
    }
  end

  factory :closed_event, parent: :event do |_event|
    limit 0
  end
end
