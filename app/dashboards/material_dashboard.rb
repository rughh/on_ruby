require "administrate/base_dashboard"

class MaterialDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    event: Field::BelongsTo,
    topic: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    preview_type: Field::String,
    preview_code: Field::String,
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
    :event,
    :topic,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :description,
    :url,
    :user,
    :event,
    :topic,
    :created_at,
    :updated_at,
    :preview_type,
    :preview_code,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :url,
    :user,
    :event,
    :topic,
    :preview_type,
    :preview_code,
  ].freeze

  def display_resource(resource)
    resource.name
  end
end
