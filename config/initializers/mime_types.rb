# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

ActionController::Renderers.add :yaml do |object, _options|
  self.content_type = 'application/yaml' if media_type.nil?
  object.to_yaml
end
