# frozen_string_literal: true

class Material < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :name, :url, :event_id, :user_id

  validates :name, :url, :event, presence: true
  validates_url :url, url: true, message: 'not a valid URL'

  belongs_to :user
  belongs_to :event
  belongs_to :topic

  scope :naked, -> { where(preview_type: nil, preview_code: nil) }

  default_scope -> { joins(:event).merge(Event.for_label(Whitelabel[:label_id])).readonly(false) }

  def generate_preview
    generator = PreviewGenerator.new(url)
    generator.generate_preview
    self.preview_type = generator.type
    self.preview_code = generator.code
    save
  end
end
