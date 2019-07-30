# typed: false
FactoryBot.define do
  factory :like do
    association :topic, strategy: :build
    association :user, strategy: :build
  end
end
