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

  def owned_by?(other_user)
    user.id == other_user.id
  end
end
