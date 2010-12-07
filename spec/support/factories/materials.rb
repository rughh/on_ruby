# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :material do |f|
  f.name "MyString"
  f.description "MyText"
  f.url "MyString"
  f.type "MyString"
  f.user nil
  f.event nil
end
