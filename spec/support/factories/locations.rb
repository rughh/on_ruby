# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :location do |f|
  f.name "MyString"
  f.url "MyString"
  f.street "MyString"
  f.house_number "MyString"
  f.city "MyString"
  f.zip "MyString"
  f.lat 1.5
  f.long 1.5
end
