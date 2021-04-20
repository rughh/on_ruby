# frozen_string_literal: true

module ShareHelper
  def share_image_url
    return request.host unless defined?(event)

    params = {
      :s => image_url("/images/onruby_share.svg"),
      :title => title,
      :subtitle => subtitle,
      :host => "#{I18n.l(event.date, format: :long)}, Host: #{I18n.t("show.hosted_by")} #{event.user.name}",
      :location => event.location ? "#{I18n.t('show.at')} #{event.location.name}, #{event.location.address}" : "",
      :participants => event.participants.count > 1 ? I18n.t("show.attendees", count: event.limit || 0, participant_count: event.participants.count) : " ",
      :logo => image_url("labels/#{event.label}.png")
    }

    return "https://p.salmo.link/render.png?#{params.to_query}"
  end
end
