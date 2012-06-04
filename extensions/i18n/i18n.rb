module I18n
  class << self
    def translate_whitelabel(token, options = {})
      t(token, options.merge(:scope => "label.#{Whitelabel[:label_id]}"))
    end
    alias :tw :translate_whitelabel
  end
end
