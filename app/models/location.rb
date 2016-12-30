class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  extend ApiHandling
  expose_api :id, :name, :url, :city, :street, :house_number, :zip, :wheelmap_id

  geocoded_by :geo_coder_address, latitude: :lat, longitude: :long
  after_validation :geocode

  has_many :events
  has_many :jobs

  validates :name, :url, :city, :street, :house_number, :zip, presence: true
  validates :url, length: { maximum: 255 }

  scope :ordered, -> { order('name ASC') }
  default_scope   -> { where(label: Whitelabel[:label_id]) }

  def geo_coder_address
    "#{street} #{house_number}, #{zip} #{city}, #{I18n.t('countries.DE')}"
  end

  def address
    "#{street} #{house_number}, #{zip} #{city}"
  end

  def nice_url
    URI.parse(url).host
  end
end
