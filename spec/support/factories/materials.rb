FactoryGirl.define do
  factory :material do
    name "any_material"
    url "http://bla.com"
    association :event
  end
end
