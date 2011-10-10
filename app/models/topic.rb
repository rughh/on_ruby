class Topic < ActiveRecord::Base

  validates :event, :name, :description, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user
  belongs_to :event

end
