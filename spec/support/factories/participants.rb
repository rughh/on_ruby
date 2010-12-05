# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :participant do |f|
  f.user_id 1
  f.event_id 1
  f.maybe false
end
