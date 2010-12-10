class Topic < ActiveRecord::Base
  
  validates :event, :name, :description, :presence => true
  
  belongs_to :user
  belongs_to :event
end
