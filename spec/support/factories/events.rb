FactoryBot.define do
  factory :event do
    name        { Faker::Lorem.words(number: 6).join }
    date        { rand(3).days.from_now }
    description { Faker::Lorem.sentences(number: 3).join }
    attendee_information { Faker::Lorem.sentences(number: 3).join }
    remote_url { Faker::Internet.url }
    association :location, strategy: :build
    association :user, strategy: :build
    created_at  { Time.now.utc }
    updated_at  { Time.now.utc }
  end

  factory :event_with_participants, parent: :event do
    after(:create) { |event| create_list(:participant, 3, event:) }
  end

  factory :full_event, parent: :event_with_participants do
    after(:create) do |event|
      event.participants  << create(:participant)
      event.materials     << create(:material)
      event.topics        << create(:topic)
    end
  end

  factory :closed_event, parent: :event do
    limit { 0 }
  end
end
