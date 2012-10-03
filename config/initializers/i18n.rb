module I18n
  class << self
    def translate_whitelabel(token, options = {})
      sub = Whitelabel.label ? Whitelabel[:label_id] : "default"
      t(token, options.merge(:scope => "label.#{sub}"))
    end
    alias :tw :translate_whitelabel
  end
end
