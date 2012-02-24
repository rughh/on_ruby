class Highlight < ActiveRecord::Base
  validates :description, :url, :start_at, :end_at, :presence => true

  scope :active, lambda { where('end_at > ?', Time.now).order('start_at').limit(1) }

  def active?
    !disabled?
  end

  def disabled?
    end_at <= Time.now
  end

  def disable!
    update_attributes! start_at: Time.now, end_at: Time.now
  end
end