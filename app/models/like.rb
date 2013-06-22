class Like < ActiveRecord::Base
  validates :user, :topic, presence: true

  belongs_to :user
  belongs_to :topic
end
