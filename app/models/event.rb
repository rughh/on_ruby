class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  
  has_many :participants
  
  def self.preview_events
    self.order('date DESC').limit(3)
  end
  
  def self.current
    self.where(:date => Time.now..(Time.now + 1.week)).first
  end
end
