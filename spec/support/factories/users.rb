# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    nickname  { Faker::Name.name.downcase.gsub(/ /, "_") }
    github    { Faker::Name.name.gsub(/\W/, "-") }
    twitter   { Faker::Name.name.gsub(/\W/, "-") }
    image 'http://www.onruby.de/assets/labels/hamburg.png'
  end

  factory :admin_user, parent: :user do
    admin true
  end

  factory :participant_user, parent: :user do
    after(:create) do |user, evaluator|
      FactoryGirl.create_list(:participant, 1, user: user)
    end
  end
end
