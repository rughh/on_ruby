# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    label           { 'hamburg' }
    name            { Faker::Name.name }
    url             { Faker::Internet.url }
    street          { Faker::Address.street_name }
    house_number    { Faker::Address.street_suffix }
    city            { Faker::Address.city }
    zip             { Faker::Address.zip_code }
    lat             { "53.5#{rand(1000)}".to_f }
    long            { "9.9#{rand(1000)}".to_f }
  end
end
