require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    authorizations: Field::HasMany,
    participants: Field::HasMany,
    materials: Field::HasMany,
    topics: Field::HasMany,
    likes: Field::HasMany,
    participations: Field::HasMany.with_options(class_name: "Event"),
    liked_topics: Field::HasMany.with_options(class_name: "Topic"),
    events: Field::HasMany,
    id: Field::Number,
    nickname: Field::String,
    name: Field::String,
    image: Field::String,
    url: Field::String,
    location: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    github: Field::String,
    admin: Field::Boolean,
    freelancer: Field::Boolean,
    available: Field::Boolean,
    hide_jobs: Field::Boolean,
    twitter: Field::String,
    email: Field::String,
    super_admin: Field::Boolean,
    linkedin: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :created_at,
    :nickname,
    :github,
    :twitter,
    :email,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :nickname,
    :name,
    :image,
    :url,
    :location,
    :description,
    :created_at,
    :updated_at,
    :github,
    :linkedin,
    :admin,
    :freelancer,
    :available,
    :hide_jobs,
    :twitter,
    :email,
    :super_admin,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :nickname,
    :name,
    :image,
    :location,
    :description,
    :email,
    :github,
    :twitter,
    :linkedin,
    :url,
    :admin,
    :freelancer,
    :available,
    :hide_jobs,
  ].freeze

  def display_resource(resource)
    resource.name
  end
end
