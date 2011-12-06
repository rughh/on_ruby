class Wish < ActiveRecord::Base

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :done
    template.add :stars
    template.add :user_id
  end

  has_friendly_id :name, :use_slug => true

  validates :name, :description, :user, :presence => true
  validates :name, :uniqueness => true

  belongs_to :user

  has_many :votes, :dependent => :destroy

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

  def twitter_message(url)
    "Neues Thema von @#{user.nickname} '#{name.truncate(50)}' #{url}"
  end

  def copy_to_topic!
    Topic.create!(name: name, description: description, user: user, event: Event.last)
    update_attributes!(done: true)
  end
end
