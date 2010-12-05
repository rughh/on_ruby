# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

locations = Location.create(
  [
    {
      :name => 'blau Mobilfunk GmbH',
      :url => 'http://www.blaumobilfunk.de',
      :street => 'Schulterblatt',
      :house_number => '124',
      :city => 'Hamburg',
      :zip => '20357',
      :lat => 53.56544,
      :long => 9.95947
    }
  ]
)
