class Material < ActiveRecord::Base
  extend ApiHandling
  expose_api :id, :name, :url, :event_id, :user_id

  validates :name, :url, :event, presence: true

  belongs_to :user
  belongs_to :event

  default_scope -> { joins(:event).where("events.label" => Whitelabel[:label_id]).readonly(false) }
end
