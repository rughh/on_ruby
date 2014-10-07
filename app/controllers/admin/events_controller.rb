class Admin::EventsController < Admin::ResourcesController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id)
  end

  def publish
    event = Event.find(params[:id])
    UsergroupMailer.invitation_mail(event).deliver!
    push_app_notification(event)
    event.update_attributes! published: true

    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id), notice: "Published!"
  end

  private

  def push_app_notification(event)
    options = {
      channel:           Usergroup.name.parameterize,
      alert:             "[#{Usergroup.name}]: new event at #{I18n.l(event.date)}",
      content_available: true
    }

    ZeroPush.broadcast(options)
  end
end
