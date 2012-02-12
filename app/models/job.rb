class Job < ActiveRecord::Base
  validates :name, :url, :location, presence: true

  belongs_to :location
end
