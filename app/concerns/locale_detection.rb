module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    if allowed_locale?(locale)
      I18n.locale = locale
    else
      I18n.locale = default_locale
    end
    cookies[:locale] = {
      value:   locale,
      expires: 1.year.from_now,
      domain:  request.domain
    }
  end

  def allowed_locale?(locale)
    OnRuby::Application.config.available_locales.include?(:"#{locale}")
  end

  def default_locale
    Whitelabel.label ? Whitelabel[:default_locale] : I18n.default_locale
  end
end
