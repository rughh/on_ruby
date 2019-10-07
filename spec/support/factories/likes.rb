# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :topic, strategy: :build
    association :user, strategy: :build
  end
end
