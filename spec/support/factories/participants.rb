# typed: false
FactoryBot.define do
  factory :participant do
    association :user, strategy: :build
    association :event, strategy: :build
  end
end
