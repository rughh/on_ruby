# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :participant do |f|
  f.user nil
  f.event nil
  f.maybe false
  f.comment "MyText"
end
