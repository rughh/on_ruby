module EventsHelper
  def participation_link(event)
    if signed_in?
      if current_user.participates?(event)
        button_to t('show.not_attend'), [event, current_user.participation(event)], method: :delete, class: 'btn btn-primary'
      elsif event.closed?
        button_to t('show.attend'), '#', data: { disable: t('flash.already_closed') }, class: 'btn btn-primary'
      else
        button_to t('show.attend'), [event, Participant.new], class: 'btn btn-primary'
      end
    else
      button_to t('show.attend'), login_path, method: :get, params: {origin: request.path}, class: 'btn btn-primary'
    end
  end

  def all_events_webcal_link
    fa_icon('calendar', text: link_to(t('events.webcal'), events_url(format: :ics, protocol: 'webcal')))
  end

  def all_events_rss_link
    fa_icon('rss', text: link_to(t('events.rss'), events_url(format: :xml)))
  end

  def events_im_attending_link
    fa_icon('calendar', text: link_to(t('events.webcal'), calendar_user_url(id: current_user, format: :ics, protocol: 'webcal')))
  end
end
