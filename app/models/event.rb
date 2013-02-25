class Event < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :description
    template.add :date
    template.add :location_id
    template.add :user_id
    template.add :participants
    template.add :topics
    template.add :materials
  end

  belongs_to :location
  belongs_to :user

  has_many :participants
  has_many :topics
  has_many :materials

  validates :location, :user, :name, :description, :date, presence: true
  validates :name, uniqueness: {scope: :label}

  attr_accessible :location_id, :user_id, :published, :name, :description, :date, as: :admin

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics

  default_scope -> { where(label: Whitelabel[:label_id]) }

  scope :current, -> { where(date: Date.today.to_time..(Time.now + 8.weeks)).limit(1).order('date ASC') }
  scope :latest, -> { where('date < ?', Date.today.to_time).order('date DESC') }
  scope :unpublished, where(published: false)
  scope :ordered, order("date DESC")

  def users
    participants.map(&:user).compact
  end

  def end_date
    date + 2.hours
  end

  def to_ical(event_url)
    ical_event = Icalendar::Event.new.tap do |e|
      e.start = date.strftime("%Y%m%dT%H%M%S")
      e.end = end_date.strftime("%Y%m%dT%H%M%S")
      e.summary = name
      e.description = "#{description} #{event_url}"
      e.location = location.name
      e.klass = "PUBLIC"
      e.created = created_at.strftime("%Y%m%dT%H%M%S")
      e.last_modified = updated_at.strftime("%Y%m%dT%H%M%S")
      e.uid = e.url = event_url
      e.add_comment("iCal Event by On Ruby!")
    end

    Icalendar::Calendar.new.tap do |cal|
      cal.add_event(ical_event)
      cal.publish
    end.to_ical
  end

  def publish_mailinglist(event_url)
    if Rails.env.production?
      UsergroupMailer.invitation_mail(self).deliver!
    else
      logger.warn "publishing in test-modus with url #{event_url}"
    end
    self.published = true
    self.save!
  end

  class << self
    def next_event_date
      Whitelabel.label.next_event_date
    end

    def duplicate!
      latest  = Event.last
      date    = Event.next_event_date
      Event.new.tap do |it|
        it.name         = "#{I18n.tw('name')} - #{I18n.l date, locale: :de, format: :month}"
        it.date         = date
        it.user         = latest.user
        it.location     = latest.location
        it.description  = latest.description
        it.save!
      end
    end
  end
end
