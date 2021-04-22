# frozen_string_literal: true

class Event < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :name, :description, :date, :location_id, :user_id, :participants, :topics, :materials, :location

  belongs_to :location, optional: true
  belongs_to :user

  has_many :participants
  has_many :users, through: :participants
  has_many :topics
  has_many :speakers, through: :topics
  has_many :materials

  validates :user, :name, :description, :date, presence: true
  validates :name, uniqueness: { scope: :label }

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics

  default_scope       -> { where(label: Whitelabel[:label_id]) }

  scope :with_topics, -> { joins(:topics).distinct }
  scope :current,     -> { where(date: Date.today.to_time..(Time.now + 9.weeks)).limit(1).order('date ASC') }
  scope :latest,      -> { where('date < ?', Date.today.to_time).order('date DESC') }
  scope :unpublished, -> { where('published IS NULL') }
  scope :ordered,     -> { order('date DESC') }

  def end_date
    date + 2.hours
  end

  def image_url
    [
      'https://cdn.sanity.io/images/dw2vc3vx/production/2f82ce2de3b4b16548b4bb2af2598874af009039-1920x1080.jpg?w=1600&h=900&fit=crop&fm=webp',
      'https://cdn.sanity.io/images/dw2vc3vx/production/ba5a5efefcf1694e9b3a8601e01903f6f87dd2c6-1920x1080.jpg?w=1600&h=900&fit=crop&fm=webp',
      'https://cdn.sanity.io/images/dw2vc3vx/production/a58d5ed199a0b790a9215569780409d7fe2e1cb4-2040x1020.jpg?w=1600&h=800&fit=crop&fm=webp',
      'https://cdn.sanity.io/images/dw2vc3vx/production/72e784322a78ec9006e546bcc1a36c02252e10f0-1920x1080.jpg?w=1600&h=900&fit=crop&fm=webp',
    ].shuffle.first
  end

  def closed?
    limit.present? && participants.count >= limit
  end

  def particpate(user)
    return false if users.include? user

    !!participants.create!(user: user)
  end

  class << self
    def duplicate!
      latest  = Event.last
      date    = Whitelabel[:next_event_date]
      Event.new.tap do |it|
        it.name         = "#{I18n.tw('name')} - #{I18n.l date, locale: :de, format: :month}"
        it.date         = date
        it.user         = latest.user
        it.location     = latest.location
        it.description  = latest.description
        it.save!
      end
    end

    def stats(size: 10)
      stats = Event.limit(size).map { |event| [event.participants.count, event.topics.count] }
      {
        participants: stats.empty? ? 0 : stats.map(&:first).sum / stats.size,
        topics: stats.empty? ? 0 : stats.map(&:last).sum / stats.size,
      }
    end
  end
end
