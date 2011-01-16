class User < ActiveRecord::Base

  validates :nickname, :name, :image, :presence => true

  has_many :authorizations
  has_many :participants

  attr_accessible :github

  def participates?(event)
    participants.any? { |participant| participant.event_id == event.id }
  end

  def participation(event)
    participants.find(:first, :conditions => [ "event_id = ?", event.id])
  end

  def twurl
    "http://twitter.com/#{nickname}"
  end

  def admin?
    nickname == AppConfig.admin
  end

  def email # needed for RailsAdmin
    nickname
  end

  def github
    self['github'].blank? ? nickname : self['github']
  end

  def self.random(num=50)
    all.shuffle[0, num].reject{|u| u.nil? }
  end

  def self.create_from_hash!(hash)
    create do |user|
      user.nickname     = hash['user_info']['nickname']
      user.name         = hash['user_info']['name']
      user.location     = hash['user_info']['location']
      user.image        = hash['user_info']['image']
      user.description  = hash['user_info']['description']
      user.url          = hash['user_info']['urls']['Website']
    end
  end

end
