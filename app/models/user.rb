class User < ActiveRecord::Base

  validates :nickname, :name, :image, presence: true
  validates :github, format: {with: /^\w+$/, allow_nil: true, allow_blank: true}

  has_many :authorizations
  has_many :participants

  attr_accessible :github, :name, :freelancer, :available

  scope :organizer, where(nickname: ['halfbyte', 'ralph', 'phoet', 'rubiii'])

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
    self.nickname     = hash['user_info']['nickname']
    self.name         = hash['user_info']['name']
    self.location     = hash['user_info']['location']
    self.image        = hash['user_info']['image']
    self.description  = hash['user_info']['description']
    self.url          = hash['user_info']['urls']['Website']
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
