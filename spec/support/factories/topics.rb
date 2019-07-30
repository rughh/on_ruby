# typed: false
FactoryBot.define do
  factory :proposal, class: :topic do
    user
    name            { Faker::Lorem.words(5).join }
    description     { Faker::Lorem.sentences(3).join }
    proposal_type   { 'proposal' }
  end

  factory :topic, parent: :proposal do
    event
  end
end
