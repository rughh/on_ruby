FactoryGirl.define do
  factory :authorization do
    provider "provider"
    uid "uid"
    association :user, :factory => :user
  end
end
