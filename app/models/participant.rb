class Participant < ActiveRecord::Base

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :user_id
    template.add :event_id
  end

  validates :user, :event, presence: true

  attr_accessible :user, :event

  belongs_to :user
  belongs_to :event

  default_scope -> { joins(:event).where("events.label" => Whitelabel[:label_id]) }

  def owned_by?(other_user)
    user.id == other_user.id
  end
end
