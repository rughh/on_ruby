require 'active_support/concern'

module WhitelabelTranslation
  extend ActiveSupport::Concern

  module ClassMethods
    def translate_whitelabel(token, options = {})
      sub = Whitelabel.label ? Whitelabel[:label_id] : "default"
      t(token, options.merge(scope: "label.#{sub}"))
    end
    alias :tw :translate_whitelabel
  end
end

module I18n
  include WhitelabelTranslation
end
