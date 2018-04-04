module WhitelabelTranslation
  def translate_whitelabel(token, options = {})
    sub = Whitelabel.label ? Whitelabel[:label_id] : 'default'
    t("label.#{sub}.#{token}".to_sym, options.merge(default: ["label.default.#{token}".to_sym, token.to_sym]))
  end
  alias tw translate_whitelabel
end
