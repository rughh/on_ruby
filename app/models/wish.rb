class Wish < ActiveRecord::Base

  belongs_to :user
  has_many :votes, :dependent => :destroy

  validates :name, :description, :user, :presence => true

  def stars
    return 0 if votes.empty?
    votes.sum(:count) / votes.count.to_f
  end

  def already_voted?(user)
    votes.any?{|vote| vote.user == user}
  end

  def publish(wish_url)
    return true unless Rails.env.production?
    url = Bitly.new.shorten(wish_url).short_url
    Twitter.update(twitter_message(url))
  end

  def twitter_message(url)
    "Neuer Wunsch von @#{user.nickname} '#{name.truncate(50)}' #{url}"
  end

end
