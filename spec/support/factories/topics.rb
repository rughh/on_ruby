# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :topic do |f|
  f.name "MyString"
  f.description "MyText"
  f.user nil
  f.event nil
end
