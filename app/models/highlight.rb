# typed: false
class Highlight < ApplicationRecord
  validates :description, :url, :start_at, :end_at, presence: true

  default_scope -> { where(label: Whitelabel[:label_id]) }

  scope :active, -> { where('end_at > ?', Time.now).order('start_at').limit(1) }

  def disabled?
    end_at <= Time.now
  end

  def disable!
    update! start_at: Time.now, end_at: Time.now
  end
end
