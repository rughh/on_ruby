class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  extend ApiHandling
  expose_api :id, :name, :url, :city, :street, :house_number, :zip

  geocoded_by :full_address, latitude: :lat, longitude: :long
  after_validation :geocode

  has_many :events
  has_many :jobs

  validates :name, :url, :city, :street, :house_number, :zip, presence: true
  validates :url, length: {maximum: 255}

  scope :ordered, -> { order("name ASC") }
  default_scope   -> { where(label: Whitelabel[:label_id]) }

  def full_address
    "#{address}, #{I18n.t('countries.DE')}"
  end

  def address
    "#{street} #{house_number}, #{zip} #{city}"
  end

  def nice_url
    URI.parse(url).host
  end

  def as_json(options = {})
    super(options.reverse_merge(:methods => :wheelchair_status))
  end

  # returns "yes", "no", "limited" or "unknown"
  def wheelchair_status
    if self.wheelmap_id
      raw = Rails.cache.fetch( "cached_wheelmap_status_#{self.wheelmap_id}", expires_in: 1.hour ) do
        WheelmapApi.wheelbase_wheelchair_status( self.wheelmap_id )
      end
      return I18n.t("location.wheelchair_status.#{raw}")
    else
      I18n.t("location.wheelchair_status.unknown")
    end
  end

end
