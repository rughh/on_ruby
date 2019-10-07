# frozen_string_literal: true

require 'administrate/base_dashboard'

class EventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    location: Field::BelongsTo,
    user: Field::BelongsTo,
    participants: Field::HasMany,
    users: Field::HasMany,
    topics: Field::HasMany,
    materials: Field::HasMany,
    id: Field::Number,
    github_issue: Field::Number,
    name: Field::String,
    date: Field::DateTime,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    published: Field::Boolean,
    label: Field::String,
    limit: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    created_at
    name
    date
    location
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    location
    user
    participants
    users
    topics
    materials
    id
    name
    date
    description
    created_at
    updated_at
    published
    label
    limit
    github_issue
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    date
    name
    description
    user
    location
    limit
    github_issue
  ].freeze

  def display_resource(event)
    "#{event.name} (#{event.date.to_date.to_s :short})"
  end
end
