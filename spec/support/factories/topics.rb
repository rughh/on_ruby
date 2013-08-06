FactoryGirl.define do
  factory :topic do
    name            { Faker::Lorem.words(5).join }
    description     { Faker::Lorem.sentences(3).join }
    proposal_type   'proposal'
    association     :user
    association     :event
  end
end
