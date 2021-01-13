# frozen_string_literal: true

class Location < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :name, :url, :virtual, :city, :street, :house_number, :zip, :wheelmap_id

  geocoded_by :geo_coder_address, latitude: :lat, longitude: :long
  after_validation :geocode, unless: :virtual?

  has_many :events
  has_many :jobs

  validates :name, :url, presence: true
  validates :city, :street, :house_number, :zip, presence: true, unless: :virtual?
  validates :url, length: { maximum: 255 }

  scope :ordered, -> { order('name ASC') }
  default_scope   -> { where(label: Whitelabel[:label_id]) }

  def geo_coder_address
    "#{street} #{house_number}, #{zip} #{city}, #{country}"
  end

  def country
    Whitelabel.find_label(label).country
  end

  def address
    "#{street} #{house_number}, #{zip} #{city}"
  end

  def nice_url
    URI.parse(url).host
  end
end
