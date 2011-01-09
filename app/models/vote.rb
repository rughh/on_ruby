class Vote < ActiveRecord::Base
  
  validates :count, :user, :wish, :presence => true
  
  belongs_to :wish
  belongs_to :user
end
