# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :location do |f|
  f.name "Blau Mobilfunk GmbH"
  f.url "http://www.blaumobilfunk.de"
  f.street "Schanzenstr."
  f.house_number "85"
  f.city "Hamburg"
  f.zip "20357"
  f.lat 53.56544
  f.long 9.95947
end
