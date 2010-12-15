class Location < ActiveRecord::Base

  validates :name, :url, :city, :street, :house_number, :zip, :lat, :long, :presence => true

end
