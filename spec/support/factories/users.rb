# encoding: UTF-8

FactoryGirl.define do
  factory :user do
    name 'Uschi Müller'
    sequence(:nickname){|n| "uschi #{n}"}
    image 'http://onruby.de/logo.png'
    github 'giddiup'
  end
end
