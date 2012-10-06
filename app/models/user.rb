class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname, use: :slugged

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :nickname
    template.add :name
    template.add :image
    template.add :url
    template.add :github
    template.add :freelancer
    template.add :available
  end

  validates :nickname, :name, :image, presence: true
  validates :github, format: {with: /^\w+$/, allow_nil: true, allow_blank: true}

  has_many :authorizations
  has_many :participants
  has_many :materials
  has_many :topics
  has_many :wishes
  has_many :events

  attr_accessible :github, :name, :freelancer, :available, :hide_jobs, :participants, :image, :url
  attr_accessible :github, :name, :freelancer, :available, :hide_jobs, :participants, :image, :url, :nickname, :admin, as: :admin

  scope :organizers, -> { where(nickname: Whitelabel[:organizers]) }
  scope :ordered, order('created_at DESC')

  def participates?(event)
    participants.any? { |participant| participant.event_id == event.id }
  end

  def participation(event)
    participants.find(:first, conditions: [ "event_id = ?", event.id])
  end

  def salt
    authorizations.first.uid
  end

  def update_from_auth!(hash)
    handle_attributes(hash)
    save! if changed?
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
    def all_for_selections
      order("name").map { |user| ["#{user.name} (#{user.nickname})", user.id] }
    end

    def peers
      joins(:participants => :event).where("events.label" => Whitelabel[:label_id]).order("created_at DESC").uniq
    end

    def main
      User.find_by_nickname(Whitelabel[:twitter])
    end

    def random(num=50)
      all.shuffle[0, num].reject{|u| u.nil? }
    end

    def create_from_hash!(hash)
      create do |user|
        user.handle_attributes(hash)
      end
    end

    def authenticated_with_token(id, stored_salt)
      u = find_by_id(id)
      u && u.salt == stored_salt ? u : nil
    end

    def find_by_session_or_cookies(session, cookies)
      find_by_id(session[:user_id]) || authenticated_with_token(*(cookies.signed[:remember_me] || ['', '']))
    end
  end
end
