class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname, use: [:slugged, :finders]

  extend ApiHandling
  expose_api :id, :nickname, :name, :image, :url, :github, :twitter, :freelancer, :available

  validates :nickname, :name, :image, presence: true
  validates :nickname, uniqueness: true
  validates :twitter, :github, uniqueness: true, allow_nil: true, allow_blank: true
  validates :twitter, :github, format: { with: /\A(\w|-)+\z/, allow_nil: true, allow_blank: true }

  has_many :authorizations, dependent: :destroy
  has_many :participants,   {dependent: :destroy}, -> { order('created_at DESC') }
  has_many :materials,      {dependent: :destroy}, -> { order('created_at DESC') }
  has_many :topics,         {dependent: :destroy}, -> { order('created_at DESC') }
  has_many :likes,          {dependent: :destroy}, -> { order('created_at DESC') }
  has_many :participations, through: :participants, source: :event
  has_many :liked_topics,   through: :likes, source: :topic
  has_many :events, -> { order('created_at DESC') }

  scope :organizers, -> { where(nickname: Whitelabel[:organizers]) }
  scope :ordered,    -> { order('updated_at DESC') }
  scope :peers,      -> { ordered.joins(participants: :event).where("events.label" => Whitelabel[:label_id]).uniq }
  scope :main,       -> { where(nickname: Whitelabel[:twitter]) }

  def participates?(event)
    participants.any? { |participant| participant.event_id == event.id }
  end

  def participation(event)
    participants.where(event_id: event.id).first
  end

  def url
    return unless url = read_attribute(:url)
    url =~ /\Ahttps?:\/\/.+/ ? url : "http://#{url}"
  end

  def salt
    authorizations.first.uid
  end

  def update_from_auth!(hash)
    send :"handle_#{hash['provider']}_attributes", hash
    save! if changed?
    self
  end

  def handle_twitter_attributes(hash)
    self.nickname     = hash['info']['nickname'] unless self.nickname
    self.twitter      = hash['info']['nickname']
    self.name         = hash['info']['name']
    self.image        = hash['info']['image']
    self.url          = hash['info']['urls']['Website']
    self.description  = hash['info']['description']
    self.location     = hash['info']['location']
  end

  def handle_github_attributes(hash)
    self.nickname     = hash['info']['nickname'] unless self.nickname
    self.github       = hash['info']['nickname']
    self.email        = hash['info']['email'] unless self.email
    self.name         = hash['info']['name'].blank? ? hash['info']['nickname'] : hash['info']['name']
    self.image        = hash['info']['image']
    self.url          = hash['info']['urls']['Blog'] || hash['info']['urls']['GitHub']
    self.description  = hash['extra']['raw_info']['bio']
    self.location     = hash['extra']['raw_info']['location']
  end

  def with_provider?(provider)
    authorizations.map(&:provider).include?("#{provider}")
  end

  class DuplicateNickname < StandardError
    attr_reader :nickname

    def initialize(nickname)
      @nickname = nickname
    end
  end

  class << self
    def find_or_create_from_hash!(hash)
      provider = hash['provider']
      nickname = hash['info']['nickname']
      user = self.find_or_initialize_by(provider => nickname)
      if !user.persisted? && self.find_by_nickname(nickname)
        raise DuplicateNickname.new(nickname)
      end
      user.update_from_auth! hash
    end

    def authenticated_with_token(id, stored_salt)
      user = find_by_id(id)
      user && user.salt == stored_salt ? user : nil
    end

    def find_by_session_or_cookies(session, cookies)
      find_by_id(session[:user_id]) || authenticated_with_token(*(cookies.signed[:remember_me] || ['', '']))
    end
  end
end
