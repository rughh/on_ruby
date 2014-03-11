class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  extend ApiHandling
  expose_api :id, :name, :description, :date, :location_id, :user_id, :participants, :topics, :materials, :location

  belongs_to :location
  belongs_to :user

  has_many :participants
  has_many :users, through: :participants
  has_many :topics
  has_many :materials

  validates :user, :name, :description, :date, presence: true
  validates :name, uniqueness: {scope: :label}

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics

  default_scope       -> { where(label: Whitelabel[:label_id]) }

  scope :with_topics, -> { joins(:topics).uniq }
  scope :current,     -> { where(date: Date.today.to_time..(Time.now + 8.weeks)).limit(1).order('date ASC') }
  scope :latest,      -> { where('date < ?', Date.today.to_time).order('date DESC') }
  scope :unpublished, -> { where("published = ? OR published = ?", nil, false) }
  scope :ordered,     -> { order("date DESC") }

  def end_date
    date + 2.hours
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

    def stats
      stats = Event.limit(10).map { |event| [event.participants.count, event.topics.count] }
      {
        participants: stats.map(&:first).sum / stats.size,
        topics: stats.map(&:last).sum / stats.size,
      }
    end
  end
end
