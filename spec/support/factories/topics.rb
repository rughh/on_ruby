# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :topic do |f|
  f.sequence(:name) { |n| "topic name #{n}" }
  f.description "some description"
  f.association :user
  f.association :event
end
