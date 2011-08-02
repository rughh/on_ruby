class Event < ActiveRecord::Base

  has_friendly_id :name, :use_slug => true

  belongs_to :location
  belongs_to :user

  has_many :participants
  has_many :topics
  has_many :materials

  validates :location, :user, :name, :description, :date, :presence => true

  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics
  
  scope :current, lambda{ where(:date => Date.today.to_time..(Time.now + 2.weeks)) }
  scope :latest, limit(5).order('date DESC')

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

  def publish(event_url)
    url = Bitly.new.shorten(event_url).short_url
    Twitter.update(twitter_message(url))
    UsergroupMailer.invitation_mail(self).deliver!
    update_attributes!(:published => true)
  end

  def twitter_message(url)
    "#{name} am #{I18n.l date, :locale => :de, :format => :short} - #{url}"
  end

end
