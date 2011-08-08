class Location < ActiveRecord::Base
  
  geocoded_by :full_address, latitude: :lat, longitude: :long
  after_validation :geocode

  has_many :events

  validates :name, :url, :city, :street, :house_number, :zip, :presence => true

  scope :company, where(company: true)
  scope :cometogether, joins(:event)
  
  def full_address
    "#{street} #{house_number}, #{zip} #{city}, Deutschland"
  end
  
  # def self.cometogether
  #   # hm, joins is not working on Location, produces strange sql:
  #   # Location Load (0.2ms)  SELECT "locations".* FROM "locations" INNER JOIN "events" ON "events"."id" IS NULL
  #   Event.joins(:location).includes(:location).map(&:location)
  # end

end
