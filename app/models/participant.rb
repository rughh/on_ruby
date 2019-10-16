class Participant < ApplicationRecord
  extend ApiHandling
  expose_api :id, :user_id, :event_id

  validates :user, :event, presence: true

  belongs_to :user
  belongs_to :event

  def owned_by?(other_user)
    user.id == other_user.id
  end
end
