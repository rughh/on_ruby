class Vote < ActiveRecord::Base
  validates :count, :user, :wish, presence: true

  attr_accessible :count, :user, :wish

  belongs_to :wish
  belongs_to :user
end
