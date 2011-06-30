class Wish < ActiveRecord::Base

  ACTIVITY_WISH     = 'WISH'
  ACTIVITY_PROPOSAL = 'PROPOSAL'

  ACTIVITIES = [ACTIVITY_WISH, ACTIVITY_PROPOSAL]

  belongs_to :user
  has_many :votes

  validates :name, :description, :user, :activity, :presence => true

  def stars
    return 0 if votes.empty?
    votes.sum(:count) / votes.count
  end

  def already_voted?(user)
    votes.any?{|vote| vote.user == user}
  end

  def publish(wish_url)
    url = Bitly.new.shorten(event_url).short_url
    Twitter.update(twitter_message(url))
  end

  def twitter_message(url)
    "@#{user.nickname} hat einen Wunsch eingestellt: '#{name.shorten(50)}' #{url}"
  end

end
