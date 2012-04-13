class Job < ActiveRecord::Base
  validates :name, :url, :location, presence: true

  attr_accessible :name, :url, :location

  belongs_to :location
end
