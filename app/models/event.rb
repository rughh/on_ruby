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
    ical_event = Icalendar::Event.new
    ical_event.start = date.strftime("%Y%m%dT%H%M%S")
    ical_event.end = end_date.strftime("%Y%m%dT%H%M%S")
    ical_event.summary = name
    ical_event.description = description
    ical_event.location = location.name
    ical_event.klass = "PUBLIC"
    ical_event.created = created_at
    ical_event.last_modified = updated_at
    ical_event.uid = ical_event.url = path
    ical_event.add_comment("iCal Event by Hamburg on Ruby!")

    calendar = Icalendar::Calendar.new
    calendar.add_event(ical_event)
    calendar.publish
    calendar.to_ical
  end

  def publish!(event_url)
    # TODO (ps) add publishing for XING, NEWSGROUP
    url = Bitly.new.shorten(event_url).short_url
    Twitter.update("#{name} am #{date} - #{url}")
    update_attributes!(:published => true)
  end

  def self.preview_events
    self.order('date DESC').limit(2)
  end

  def self.current
    self.where(:date => Date.today.to_time..(Time.now + 1.week)).first
  end

end

