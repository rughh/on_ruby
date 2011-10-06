class Material < ActiveRecord::Base

  validates :name, :url, :event, :presence => true

  belongs_to :user
  belongs_to :event

end
