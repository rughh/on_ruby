# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :authorization do |f|
  f.provider "MyString"
  f.uid "MyString"
  f.user_id 1
end
