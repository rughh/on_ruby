class GeoJob < BaseJob
  def perform(codeable)
    codeable.geocode
    codeable.save!
  end
end
