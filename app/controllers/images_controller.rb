# frozen_string_literal: true

class ImagesController < ActionController::Base
  PUBLIC_MOUNTS = {
    'User' => :image
  }.freeze

  def show
    http_cache_forever(public: true) do
      model_name = params[:model_name]
      attribute_name = PUBLIC_MOUNTS[model_name]
      head(:not_authorized) && return unless attribute_name

      filename = params[:filename]
      model_class = model_name.constantize
      model = model_class.find(params[:model_id])
      url = model.send(attribute_name)

      if url.present?
        open(url) do |f|
          send_data(f.read, filename: filename, disposition: :inline, content_type: f.content_type)
        end
      else
        Rails.logger.warn("there is no uploaded file for params #{params}")

        send_default_image
      end
    end
  rescue StandardError
    Rails.logger.warn("an error coccured dispatching image with params #{params}: #{$ERROR_INFO}")

    send_default_image
  end

  private

  def send_default_image
    send_file(Rails.root.join('app/assets/images/logo.gif').to_s, filename: 'default-image.gif', disposition: :inline, content_type: 'image/gif')
  end
end
