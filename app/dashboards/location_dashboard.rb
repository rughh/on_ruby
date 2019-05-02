require "administrate/base_dashboard"

class LocationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    jobs: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    url: Field::String,
    street: Field::String,
    house_number: Field::String,
    city: Field::String,
    zip: Field::String,
    lat: Field::Number.with_options(decimals: 2),
    long: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    company: Field::Boolean,
    label: Field::String,
    wheelmap_id: Field::String,
    address: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :created_at,
    :name,
    :address,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :company,
    :events,
    :jobs,
    :id,
    :name,
    :url,
    :street,
    :house_number,
    :city,
    :zip,
    :lat,
    :long,
    :created_at,
    :updated_at,
    :wheelmap_id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :company,
    :url,
    :street,
    :house_number,
    :city,
    :zip,
    :wheelmap_id,
  ].freeze

  def display_resource(location)
    location.name
  end
end
