# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :authorization do |f|
  f.provider "provider"
  f.uid "uid"
  f.association :user, :factory => :user
end
