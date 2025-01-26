Usergroup.initialize!

I18n.extend WhitelabelTranslation

Rails.application.config.middleware.insert_before OmniAuth::Builder, WhitelabelDetectionMiddleware
