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

  attr_accessible :location, :user, :name, :description, :date

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics

  default_scope -> { where(:label => Whitelabel[:label_id]) }

  scope :current, lambda{ where(date: Date.today.to_time..(Time.now + 4.weeks)).limit(1) }
  scope :latest, where('date < ?', Time.now).order('date DESC')
  scope :unpublished, where(published: false)
  scope :ordered, order("date DESC")

  def end_date
    date + 2.hours
  end

  def to_ical(path)
    ical_event = Icalendar::Event.new.tap do |e|
      e.start = date.strftime("%Y%m%dT%H%M%S")
      e.end = end_date.strftime("%Y%m%dT%H%M%S")
      e.summary = name
      e.description = description
      e.location = location.name
      e.klass = "PUBLIC"
      e.created = created_at
      e.last_modified = updated_at
      e.uid = e.url = path
      e.add_comment("iCal Event by Hamburg on Ruby!")
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
    update_attributes!(published: true)
  end

  def twitter_message(url)
    "#{name} am #{I18n.l date, locale: :de, format: :short} - #{url}"
  end

  class << self

    def next_event_date
      d = second_wednesday(Date.today)
      d = second_wednesday(Date.today.next_month) if d < Date.today
      Time.new(d.year, d.month, d.day, 19, 0)
    end

    def second_wednesday(date)
      d = date.at_beginning_of_month
      d.wday > 3 ? d + (17 - d.wday).days : d + (10 - d.wday)
    end

    def duplicate!
      Event.last.dup.tap do |it|
        it.date = Event.next_event_date
        it.name = "Ruby Usergroup Hamburg - #{I18n.l it.date, locale: :de, format: :month}"
        it.published = false
        it.save!
      end
    end
  end

end
