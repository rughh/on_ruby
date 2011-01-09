# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :vote do |f|
  f.association :wish
  f.association :user
  f.count 5
  f.comment "MyText"
end
