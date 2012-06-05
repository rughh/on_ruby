class Job < ActiveRecord::Base
  validates :name, :url, :location, presence: true

  attr_accessible :name, :url, :location, as: :admin

  default_scope -> { where(:label => Whitelabel[:label_id]) }

  belongs_to :location
end
