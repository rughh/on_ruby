class Location < ActiveRecord::Base
  
  validates_presence_of :name, :street, :house_number, :city, :zip, :lat, :long
  
end
