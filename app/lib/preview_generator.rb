# typed: true
class PreviewGenerator
  attr_accessor :uri, :type, :code

  def initialize(uri)
    @uri = uri
  end

  def generate_preview
    website = LinkThumbnailer.generate(uri)

    video = website.videos.find { |v| v.embed_code.present? }
    if video
      self.code = video.embed_code
      self.type = :video
    else
      image = website.images.first
      if image
        self.code = image.src
        self.type = :image
      else
        self.type = :none
      end
    end
  rescue Net::HTTPServerException => e
    Rails.logger.warn("Could not generate preview for url #{uri}: #{e}")
  end

  def video?
    type == :video
  end

  def image?
    type == :image
  end

  def none?
    type == :none
  end
end
