# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :event do |f|
  f.name "MyString"
  f.date "2010-12-06 11:47:30"
  f.description "MyText"
  f.location nil
  f.user nil
end
