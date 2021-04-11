# frozen_string_literal: true

module ShareHelper
  def share_image_url
    return request.host unless defined?(event)

    params = {
      :s => image_url("/images/onruby_share.svg"),
      :title => page_title,
      :subtitle => "#{I18n.t("show.hosted_by")} #{event.user.name}",
      :date => "#{I18n.l(event.date, format: :long)}",
      :location => event.location ? "#{I18n.t('show.at')} #{event.location}" : "",
      :participants => event.participants.count > 1 ? event.participants.count : " ",
      :logo => image_url("labels/#{event.label}.png")
    }

    return "https://p.salmo.link/render.png?#{params.to_query}"
  end

  private 

  def share_event_details
    "#{I18n.t("show.hosted_by")} #{event.user.name} #{I18n.t('show.at')} #{event.location}"
  end
end
