# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :participant do |f|
  f.association :user, :factory => :user
  f.association :event, :factory => :event
  f.maybe false
  f.comment "MyText"
end
