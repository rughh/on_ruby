# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :wish do |f|
  f.name "MyString"
  f.description "MyText"
  f.activity Wish::ACTIVITIES.first
  f.association :user
end
