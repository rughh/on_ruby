class Vote < ActiveRecord::Base
  validates :count, :user, :wish, presence: true

  attr_accessible :count, :user, :wish

  belongs_to :wish
  belongs_to :user

  after_save do |vote|
    vote.wish.update_stars!
  end
end
