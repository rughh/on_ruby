FactoryBot.define do
  factory :proposal, class: :topic do
    name            { Faker::Lorem.words(5).join }
    description     { Faker::Lorem.sentences(3).join }
    proposal_type   'proposal'
    association     :user, strategy: :build
  end

  factory :topic, parent: :proposal do
    association :event, strategy: :build
  end
end
