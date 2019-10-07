# frozen_string_literal: true

class Job < ApplicationRecord
  validates :name, :url, :location, presence: true

  default_scope -> { where(label: Whitelabel[:label_id]) }

  belongs_to :location

  def self.shuffled
    includes(:location).shuffle
  end
end
