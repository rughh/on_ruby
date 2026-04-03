require Rails.root.join('app/lib/whitelabel_detection_middleware')
require Rails.root.join('app/lib/whitelabel_translation')

Rails.application.config.to_prepare do
  Usergroup.initialize!
  I18n.extend WhitelabelTranslation unless I18n.is_a?(WhitelabelTranslation)
end

Rails.application.config.middleware.insert_before OmniAuth::Builder, WhitelabelDetectionMiddleware
