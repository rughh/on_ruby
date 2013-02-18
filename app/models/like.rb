class Like < ActiveRecord::Base
  validates :user, :topic, presence: true

  attr_accessible :user, :topic

  belongs_to :user
  belongs_to :topic
end
