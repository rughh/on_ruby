class Admin::EventsController < Admin::ResourcesController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: '/admin/events', action: :edit, id: event.id)
  end

  def publish
    event = Event.find_by_slug(params[:id])
    UsergroupMailer.invitation_mail(event).deliver_now!
    event.update_attributes! published: true

    redirect_to url_for(controller: '/admin/events', action: :edit, id: event.id), notice: 'Published!'
  end

  def send_ios_push_notification
    event = Event.find_by_slug(params[:id])

    options = {
      app_id: ENV['ONE_SIGNAL_APP_ID'],
      included_segments: [Whitelabel[:label_id]],
      contents: {
        en: "#{I18n.tw('name')}: new event at #{I18n.l(event.date)}"
      },
      content_available: true
    }

    notification_call = OneSignal::Notification.create(params: options)

    if notification_call.code == '200'
      message = { notice: 'iOS Push Notification sent!' }
    else
      message = { alert: 'iOS Push Notification could not be sent!' }
    end

    redirect_to url_for(controller: '/admin/events', action: :show, id: event.id), message
  end
end
