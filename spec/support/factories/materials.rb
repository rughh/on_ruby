# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :material do |f|
  f.name "any_material"
  f.url "http://bla.com"
  f.association :event
end
