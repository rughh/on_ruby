class Wish < ActiveRecord::Base
  
  ACTIVITIES = ['WISH', 'PROPOSAL']
  
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
end
