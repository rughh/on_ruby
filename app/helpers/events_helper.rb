module EventsHelper
  def participation_link(event)
    if signed_in?
      if current_user.participates?(event)
        button_to t("show.not_attend"), [event, current_user.participation(event)], method: :delete
      elsif event.closed?
        button_to t("show.attend"), "#", data: {disable: t("flash.already_closed")}
      else
        button_to t("show.attend"), [event, Participant.new]
      end
    else
      button_to t("show.attend"), "#", data: {disable: t("show.login_before_attend")}
    end
  end

  def all_events_webcal_link
    fa_icon('calendar') + ' ' +
    link_to(t('events.webcal'), events_url(format: :ics, protocol: "webcal"))
  end

  def all_events_rss_link
    fa_icon('rss') + ' ' +
    link_to(t('events.rss'), events_url(format: :xml))
  end

  def events_im_attending_link
    fa_icon('calendar') + ' ' +
    link_to(t('events.webcal'), calendar_user_url(id: current_user, format: :ics, protocol: "webcal"))
  end
end
