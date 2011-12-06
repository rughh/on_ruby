class Material < ActiveRecord::Base

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :url
    template.add :event_id
    template.add :user_id
  end

  validates :name, :url, :event, :presence => true

  belongs_to :user
  belongs_to :event

end
