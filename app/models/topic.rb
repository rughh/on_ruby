class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :event_id
    template.add :user_id
    template.add :name
    template.add :description
  end

  validates :user, :name, :description, :label, presence: true
  validates :name, uniqueness: true

  attr_accessible :label, :name, :user, :description
  attr_accessible :label, :name, :event, :event_id, :user, :user_id, :description, as: :admin

  belongs_to :user
  belongs_to :event

  has_many :likes, dependent: :destroy

  scope :ordered, order('created_at DESC')
  scope :undone, where('event_id IS NULL')
  scope :done, where('event_id IS NOT NULL')

  default_scope -> { where(label: Whitelabel[:label_id]) }

  def already_liked?(user)
    likes.detect{ |like| like.user == user }
  end
end
