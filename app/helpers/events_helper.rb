# frozen_string_literal: true

module EventsHelper
  def participation_link(event, link_class: 'btn btn-primary')
    if signed_in?
      if current_user.participates?(event)
        link_to t('show.not_attend'), [event, current_user.participation(event)], method: :delete, class: link_class
      elsif event.closed?
        link_to t('show.attend'), '#', data: { disable: t('flash.already_closed') }, class: link_class
      else
        link_to t('show.attend'), [event, Participant.new], method: :post, class: link_class
      end
    else
      link_to t('show.attend'), login_path, params: { origin: request.path }, class: link_class
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
