# typed: true
class Topic < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :event_id, :user_id, :name, :description, :user

  PROPOSAL_TYPES = %w(proposal enquiry)
  validates :user, :name, :description, :label, presence: true
  validates :proposal_type, inclusion: { in: PROPOSAL_TYPES }

  belongs_to :user
  belongs_to :event, optional: true

  has_many :likes, dependent: :destroy
  has_many :materials

  scope :ordered,  -> { order('created_at DESC') }
  scope :undone,   -> { where('event_id IS NULL') }
  scope :done,     -> { joins(:event).where('date <= ?', Time.now - 2.hour) }
  scope :upcoming, -> { joins(:event).where('date > ?', Time.now - 2.hour) }

  default_scope -> { where(label: Whitelabel[:label_id]) }

  def already_liked?(user)
    likes.detect { |like| like.user == user }
  end
end
