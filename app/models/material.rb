class Material < ActiveRecord::Base
  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :url
    template.add :event_id
    template.add :user_id
  end

  validates :name, :url, :event, presence: true

  attr_accessible :name, :url, :description, :event_id, :user_id, as: :admin

  belongs_to :user
  belongs_to :event

  default_scope -> { joins(:event).where("events.label" => Whitelabel[:label_id]).readonly(false) }
end
