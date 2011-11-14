class Participant < ActiveRecord::Base

  acts_as_api

  api_accessible :ios do |template|
    template.add :id
    template.add :user_id
    template.add :event_id
  end

  validates :user, :event, presence: true

  belongs_to :user
  belongs_to :event

  def owned_by?(other_user)
    user.id == other_user.id
  end
end
