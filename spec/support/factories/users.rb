# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    name 'Uschi Müller'
    sequence(:nickname){|n| "uschi #{n}"}
    sequence(:github){|n| "github_#{n}"}
    sequence(:twitter){|n| "twitter_#{n}"}
    image 'http://onruby.de/logo.png'
  end

  factory :admin_user, parent: :user do
    admin true
  end
end
