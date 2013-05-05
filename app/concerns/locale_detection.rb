module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    locale ||= Whitelabel[:default_locale] if Whitelabel.label
    locale ||= I18n.default_locale
    I18n.locale = locale
    cookies[:locale] = {
      value:   locale,
      expires: 1.year.from_now,
      domain:  request.domain
    }
  end
end
