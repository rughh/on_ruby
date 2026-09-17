# frozen_string_literal: true

class Topic < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :event_id, :user_id, :name, :description, :user

  PROPOSAL_TYPES = %w[proposal enquiry].freeze
  validates :user, :name, :description, :label, presence: true
  validates :proposal_type, inclusion: { in: PROPOSAL_TYPES }
  validates :name, length: { maximum: 255 }

  belongs_to :user
  belongs_to :event, optional: true

  has_many :likes, dependent: :destroy
  has_many :materials

  scope :ordered,  -> { order(created_at: :desc) }
  scope :undone,   -> { where(event_id: nil) }
  scope :done,     -> { joins(:event).merge(Event.where(date: ..2.hours.ago)) }
  scope :upcoming, -> { joins(:event).merge(Event.where(date: 2.hours.ago...)) }

  default_scope -> { where(label: Whitelabel[:label_id]) }

  def already_liked?(user)
    likes.detect { |like| like.user == user }
  end
end
