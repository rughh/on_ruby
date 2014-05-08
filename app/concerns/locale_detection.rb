module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale]
    if locale.blank?
      if Whitelabel.label
        locale = Whitelabel[:default_locale]
      else
        locale = I18n.default_locale
      end
    end
    I18n.locale = locale
    cookies[:locale] = {
      value:   locale,
      expires: 1.year.from_now,
      domain:  request.domain
    }
  end
end
