class Material < ApplicationRecord
  include Slug
  extend ApiHandling
  expose_api :id, :name, :url, :event_id, :user_id

  validates :name, :url, :event, presence: true
  validates_url :url, url: true, message: 'not a valid URL'

  belongs_to :user
  belongs_to :event
  belongs_to :topic

  scope :naked, -> { where('preview_type IS NULL AND preview_code is NULL') }

  default_scope -> { joins(:event).where('events.label' => Whitelabel[:label_id]).readonly(false) }

  def generate_preview
    generator = PreviewGenerator.new(url)
    generator.generate_preview
    self.preview_type = generator.type
    self.preview_code = generator.code
    save
  end
end
