class Material < ActiveRecord::Base

  TYPES = %w{slide pdf video blog reference}

  validates :name, :url, :event, :material_type, :presence => true

  belongs_to :user
  belongs_to :event

end
