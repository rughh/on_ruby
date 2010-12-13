# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :event do |f|
  f.name "Weihnachtstreffen"
  f.date "2010-12-06 11:47:30"
  f.description "MyText"
  f.association :location
  f.association :user
  f.created_at "2010-12-06 11:47:30"
  f.updated_at "2010-12-06 11:47:30"
end
