class Topic < ActiveRecord::Base
  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :event_id
    template.add :user_id
    template.add :name
    template.add :description
  end

  validates :event, :name, :description, presence: true
  validates :name, uniqueness: true

  attr_accessible :name, :event, :event_id, :user, :user_id, :description, as: :admin

  belongs_to :user
  belongs_to :event

  default_scope -> { joins(:event).where("events.label" => Whitelabel[:label_id]) }
end
