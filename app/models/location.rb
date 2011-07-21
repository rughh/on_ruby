class Location < ActiveRecord::Base

  belongs_to :event

  validates :name, :url, :city, :street, :house_number, :zip, :lat, :long, :presence => true

  scope :company, where(company: true)
  
  def self.cometogether
    # hm, joins is not working on Location, produces strange sql:
    # Location Load (0.2ms)  SELECT "locations".* FROM "locations" INNER JOIN "events" ON "events"."id" IS NULL
    Event.joins(:location).includes(:location).map(&:location)
  end

end
