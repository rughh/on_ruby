class Event < ActiveRecord::Base

  belongs_to :location
  belongs_to :user

  has_many :participants
  has_many :topics
  has_many :materials

  validates :location, :user, :name, :description, :date, :presence => true

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics

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
      e.uid = ical_event.url = path
      e.add_comment("iCal Event by Hamburg on Ruby!")
    end

    Icalendar::Calendar.new.tap do |cal|
      cal.add_event(ical_event)
      cal.publish
      cal.to_ical
    end
  end

  def publish!(event_url)
    url = Bitly.new.shorten(event_url).short_url
    Twitter.update(twitter_message(url))
    UsergroupMailer.invitation_mail(self).deliver!
    update_attributes!(:published => true)
  end

  def twitter_message(url)
    "#{name} am #{I18n.l date, :locale => :de, :format => :short} - #{url}"
  end

  class << self

    def preview_events
      self.order('date DESC').limit(2)
    end

    def current
      self.where(:date => Date.today.to_time..(Time.now + 1.week)).first
    end

  end

end
