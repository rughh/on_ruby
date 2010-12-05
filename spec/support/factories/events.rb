# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :event do |f|
  f.name "MyString"
  f.date "2010-12-05 13:21:51"
  f.description "MyText"
  f.location_id 1
  f.user_id 1
end
