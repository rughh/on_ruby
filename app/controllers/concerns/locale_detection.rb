# frozen_string_literal: true

module LocaleDetection
  protected

  def switch_locale
    locale = params[:locale] || cookies[:locale] || available_accepted_locales
    I18n.locale = allowed_locale?(locale) ? locale : default_locale

    cookies[:locale] = {
      value: locale,
      expires: 1.year.from_now,
      domain: request.domain,
    }
  end

  def allowed_locale?(locale)
    I18n.available_locales.include?(:"#{locale}")
  end

  def default_locale
    Whitelabel.label ? Whitelabel[:default_locale] : I18n.default_locale
  end

  def available_accepted_locales
    (accepted_locales & I18n.available_locales).first
  end

  def accepted_locales
    locales = parsed_accepted_locales.sort_by(&:last).reverse
    locales.map(&:first)
  end

  def parsed_accepted_locales
    accepted_locales = request.env['HTTP_ACCEPT_LANGUAGE']&.split(',')
    return [] unless accepted_locales

    accepted_locales.map do |prefered_locale|
      locale, quality = prefered_locale.strip.split(/;(?:q=)/)
      [locale.strip.to_sym, quality&.to_f || 1.0]
    end
  end
end
