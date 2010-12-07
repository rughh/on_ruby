class Material < ActiveRecord::Base
  
  TYPES = %w{slide pdf video blog reference}
  
  validates :name, :user, :event, :presence => true
  
  belongs_to :user
  belongs_to :event
end
