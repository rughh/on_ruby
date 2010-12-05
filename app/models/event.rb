class Event < ActiveRecord::Base
  
  validates_presence_of :name, :date, :description
  
  belongs_to :location
  belongs_to :user
  
  has_many :participants
  
  def self.preview_events
    self.order('date DESC').limit(3)
  end
end
