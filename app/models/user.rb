class User < ActiveRecord::Base
  has_many :authorizations
  has_many :participants
  
  def participates?(event)
    participants.any?{|p| p.event_id == event.id}
  end

  def self.create_from_hash!(hash)
    create do |user|
      user.nickname = hash['user_info']['nickname']
      user.name = hash['user_info']['name']
      user.location = hash['user_info']['location']
      user.image = hash['user_info']['image']
      user.description = hash['user_info']['description']
      user.url = hash['user_info']['urls']['Website']
    end
  end
  
end
