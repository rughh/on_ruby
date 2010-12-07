class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :twitter, :format => { :with => /@.+/, :unless => "twitter.blank?" }
  validates :homepage, :format => { :with => /https?:\/\/.+/, :unless => "homepage.blank?" }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :twitter, :github, :homepage, :company
  
  has_many :events
  
  def participates?(event)
    events.any?{|e| e.id == event.id}
  end
  
  def to_s
    twitter || email
  end
end
