class Event < ActiveRecord::Base
  
  validates :location, :user, :name, :description, :date, :presence => true
  
  belongs_to :location
  belongs_to :user
  
  has_many :participants
  has_many :topics
  has_many :materials
  
  accepts_nested_attributes_for :materials
  accepts_nested_attributes_for :topics
  
  def to_s
    "#{date} #{name}"
  end
  
  def end_date
    date + 2.hours
  end

  def to_ics(path)
    event = Icalendar::Event.new
    event.start = date.strftime("%Y%m%dT%H%M%S")
    event.end = end_date.strftime("%Y%m%dT%H%M%S")
    event.summary = name
    event.description = description
    event.location = location.name
    event.klass = "PUBLIC"
    event.created = created_at
    event.last_modified = updated_at
    event.uid = event.url = path
    event.add_comment("iCal Event by Hamburg on Ruby!")
    event
  end
  
  def self.preview_events
    self.order('date DESC').limit(2)
  end
  
  def self.current
    self.where(:date => Time.now..(Time.now + 1.week)).first
  end
end
