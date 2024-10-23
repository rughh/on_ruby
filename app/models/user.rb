# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Metrics/ClassLength
  include Slug
  extend ApiHandling
  slugged_by(:nickname)
  expose_api :id, :nickname, :name, :image, :url, :github, :twitter, :freelancer, :available

  validates :nickname, :name, :image, presence: true
  validates :nickname, uniqueness: true
  validates :twitter, :github, uniqueness: true, allow_blank: true
  validates :twitter, :github, format: { with: /\A(\w|-)+\z/, allow_blank: true }

  has_many :authorizations, dependent: :destroy
  has_many :participants, -> { order('created_at DESC') }, dependent: :destroy
  has_many :materials, -> { order('created_at DESC') }, dependent: :destroy
  has_many :topics, -> { order('created_at DESC') }, dependent: :destroy
  has_many :likes, -> { order('created_at DESC') }, dependent: :destroy
  has_many :participations, through: :participants, source: :event
  has_many :liked_topics, through: :likes, source: :topic
  has_many :events, -> { order('created_at DESC') }, dependent: :nullify

  scope :organizers, -> { where(nickname: Whitelabel[:organizers]) }
  scope :ordered,    -> { order('updated_at DESC') }
  scope :peers,      -> { ordered.joins(participants: :event).where('events.label' => Whitelabel[:label_id]).distinct }
  scope :main,       -> { where(nickname: Whitelabel[:twitter]) }
  scope :random,     -> { self }

  def participates?(event)
    participants.any? { |participant| participant.event_id == event.id }
  end

  def participation(event)
    participants.where(event_id: event.id).first
  end

  def url
    return unless url = self[:url]

    url =~ %r{\Ahttps?://.+} ? url : "http://#{url}"
  end

  def salt
    authorizations.first.uid
  end

  def organizer?
    self.class.organizers.include? self
  end

  def update_from_auth!(hash)
    send :"handle_#{hash['provider']}_attributes", hash
    save! if changed?
    self
  end

  def handle_twitter_attributes(hash)
    self.nickname     = hash['info']['nickname'] unless nickname
    self.twitter      = hash['info']['nickname']
    self.name         = hash['info']['name']
    self.image        = hash['info']['image']
    self.url          = hash['info']['urls']['Website'] unless url
    self.description  = hash['info']['description'] unless description
    self.location     = hash['info']['location']
  end

  def handle_github_attributes(hash)
    self.nickname     = hash['info']['nickname'] unless nickname
    self.github       = hash['info']['nickname']
    self.email        = hash['info']['email'] unless email
    self.name         = hash['info']['name'].presence || hash['info']['nickname']
    self.image        = hash['info']['image']
    self.url          = hash['info']['urls']['Blog'] || hash['info']['urls']['GitHub'] unless url
    self.description  = hash['extra']['raw_info']['bio'] unless description
    self.location     = hash['extra']['raw_info']['location']
  end

  def handle_google_oauth2_attributes(hash)
    Rails.logger.info(hash)
    Rails.logger.info(hash['info'])
    self.nickname = hash['info']['name'] unless nickname
    self.email    = hash['info']['email'] unless email
    self.name     = hash['info']['name']
    self.image    = hash['info']['image']
  end

  def handle_email_attributes(hash)
    received_email = hash['info']['email']

    self.nickname = nickname_from_email(received_email) unless nickname
    self.name     = name_from_email(received_email) unless name
    self.image    = image_from_email(received_email) unless image
    self.email    = received_email
  end

  def hash_for_email(email)
    Digest::SHA256.new.hexdigest(email)
  end

  def nickname_from_email(email)
    hash_for_email(email)
  end

  def hide_nickname?
    nickname == nickname_from_email(email)
  end

  EMPTY_NAME = '********'

  def name_from_email(_email)
    EMPTY_NAME
  end

  def image_from_email(email)
    "https://www.gravatar.com/avatar/#{hash_for_email(email)}"
  end

  def with_provider?(provider)
    authorizations.map(&:provider).include?(provider)
  end

  def missing_name?
    name == EMPTY_NAME
  end

  class DuplicateNickname < StandardError
    attr_reader :nickname

    def initialize(nickname)
      @nickname = nickname
    end
  end

  class << self
    def create_from_hash!(hash)
      nickname = hash['info']['nickname']
      raise DuplicateNickname, nickname if find_by(nickname:)

      User.new.update_from_auth! hash
    end

    def authenticated_with_token(id, stored_salt)
      user = find_by(id:)
      user && user.salt == stored_salt ? user : nil
    end
  end
end
