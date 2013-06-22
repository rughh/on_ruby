class Admin::EventsController < Admin::BaseAdminController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id)
  end

  def publish
    event = Event.find(params[:id])
    event.publish_mailinglist(event_url(event)) unless event.published?
    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id), notice: "Published!"
  end
end
