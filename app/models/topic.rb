class Topic < ActiveRecord::Base

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :event_id
    template.add :user_id
    template.add :name
    template.add :description
  end

  validates :event, :name, :description, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user
  belongs_to :event

end
