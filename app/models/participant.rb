class Participant < ActiveRecord::Base
  
  validates :user, :event, presence: true

  belongs_to :user
  belongs_to :event

  def owned_by?(other_user)
    user.id == other_user.id
  end
end
