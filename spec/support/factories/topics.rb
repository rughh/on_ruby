# frozen_string_literal: true

FactoryBot.define do
  factory :proposal, class: :topic do
    user
    name            { Faker::Lorem.words(number: 5).join }
    description     { Faker::Lorem.sentences(number: 3).join }
    proposal_type   { 'proposal' }
  end

  factory :topic, parent: :proposal do
    event
  end
end
