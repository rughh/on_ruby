class User < ActiveRecord::Base

  acts_as_api

  api_accessible :ios do |template|
    template.add :id
    template.add :nickname
    template.add :name
    template.add :image
    template.add :url
    template.add :github
    template.add :freelancer
    template.add :available
  end

  has_friendly_id :nickname

  validates :nickname, :name, :image, presence: true
  validates :github, format: {with: /^\w+$/, allow_nil: true, allow_blank: true}

  has_many :authorizations
  has_many :participants
  has_many :materials
  has_many :topics
  has_many :wishes
  has_many :events

  attr_accessible :github, :name, :freelancer, :available

  scope :organizer, where(nickname: ['halfbyte', 'ralph', 'phoet', 'rubiii'])
  scope :ordered, order('created_at DESC')

  def participates?(event)
    participants.any? { |participant| participant.event_id == event.id }
  end

  def participation(event)
    participants.find(:first, :conditions => [ "event_id = ?", event.id])
  end

  def update_from_auth!(hash)
    handle_attributes(hash)
    save!
  end

  def handle_attributes(hash)
    self.nickname     = hash['info']['nickname']
    self.name         = hash['info']['name']
    self.location     = hash['info']['location']
    self.image        = hash['info']['image']
    self.description  = hash['info']['description']
    self.url          = hash['info']['urls']['Website']
  end

  class << self
    def main
      User.find_by_nickname(AppConfig.twitter) || User.find_by_nickname('phoet')
    end

    def random(num=50)
      all.shuffle[0, num].reject{|u| u.nil? }
    end

    def create_from_hash!(hash)
      create do |user|
        user.handle_attributes(hash)
      end
    end
  end

end
