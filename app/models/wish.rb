class Wish < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :done
    template.add :stars
    template.add :user_id
  end

  validates :name, :description, :user, presence: true
  validates :name, uniqueness: {scope: :label}

  attr_accessible :name, :done, :stars, :description, :user
  attr_accessible :name, :done, :stars, :description, :slug, :label, :user_id, as: :admin

  belongs_to :user

  has_many :votes, dependent: :destroy

  default_scope -> { where(:label => Whitelabel[:label_id]) }

  scope :done,    where(done: true).order('id DESC')
  scope :undone,  where(done: false).order('id DESC')
  scope :ordered, order('created_at DESC')

  def stars
    return 0.0 if votes.empty?
    (votes.sum(:count) / votes.count.to_f).round(1)
  end

  def already_voted?(user)
    votes.any?{|vote| vote.user == user}
  end

  def copy_to_topic!
    Topic.create!({name: name, description: description, user: user, event: Event.last}, as: :admin)
    update_attributes!(done: true)
  end
end
