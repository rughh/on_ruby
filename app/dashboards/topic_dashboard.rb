require "administrate/base_dashboard"

class TopicDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    event: Field::BelongsTo,
    likes: Field::HasMany,
    materials: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    label: Field::String,
    proposal_type: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :event,
    :likes,
    :materials,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :event,
    :likes,
    :materials,
    :id,
    :name,
    :description,
    :created_at,
    :updated_at,
    :label,
    :proposal_type,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :event,
    :likes,
    :materials,
    :name,
    :description,
    :label,
    :proposal_type,
  ].freeze

  # Overwrite this method to customize how topics are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(topic)
  #   "Topic ##{topic.id}"
  # end
end
