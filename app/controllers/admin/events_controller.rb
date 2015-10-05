class Admin::EventsController < Admin::ResourcesController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id)
  end

  def publish
    event = Event.find(params[:id])
    UsergroupMailer.invitation_mail(event).deliver_now!
    event.update_attributes! published: true

    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id), notice: "Published!"
  end

  def send_ios_push_notification
    event = Event.find(params[:id])

    options = {
      channel:           Whitelabel[:label_id],
      alert:             "#{I18n.tw('name')}: new event at #{I18n.l(event.date)}",
      content_available: true
    }

    ZeroPush.broadcast(options)

    redirect_to url_for(controller: "/admin/events", action: :show, id: event.id), alert: "iOS Push Notification sent!"
  end
end
