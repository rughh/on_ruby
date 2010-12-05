class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
