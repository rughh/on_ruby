module WhitelabelTranslation
  def translate_whitelabel(token, options = {})
    sub = Whitelabel.label ? Whitelabel[:label_id] : "default"
    t(token, options.merge(scope: "label.#{sub}"))
  end
  alias :tw :translate_whitelabel
end

module I18n
  extend WhitelabelTranslation
end
