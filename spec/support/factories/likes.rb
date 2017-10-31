FactoryBot.define do
  factory :like do
    association :topic
    association :user
  end
end
