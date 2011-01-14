class Participant < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  def owned_by?(other_user)
    user == other_user
  end
end
