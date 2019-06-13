class ImagesController < ActionController::Base
  PUBLIC_MOUNTS = {
    'User' => :image,
  }

  def show
    http_cache_forever(public: true) do
      model_name = params[:model_name]
      attribute_name = PUBLIC_MOUNTS[model_name]
      head :not_authorized and return unless attribute_name

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

        head :not_found
      end
    end
  rescue
    Rails.logger.warn("an error coccured dispatching image with params #{params}: #{$!}")

    head :not_found
  end
end
