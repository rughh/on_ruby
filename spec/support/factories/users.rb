# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name      { Faker::Name.name }
    nickname  { Faker::Name.name.downcase.tr(' ', '_') }
    github    { Faker::Name.name.gsub(/\W/, '-') }
    twitter   { Faker::Name.name.gsub(/\W/, '-') }
    email     { Faker::Internet.email }
    image     { 'http://www.onruby.de/assets/labels/hamburg.png' }
  end

  factory :admin_user, parent: :user do
    admin { true }
    super_admin { true }
  end

  factory :organizer_user, parent: :user do
    after(:create) { |user| create(:event, user: user) }
  end

  factory :participant_user, parent: :user do
    after(:create) { |user| create_list(:participant, 1, user: user) }
  end
end
