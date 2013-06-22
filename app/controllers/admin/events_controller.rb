class Admin::EventsController < Admin::ResourcesController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id)
  end

  def publish
    event = Event.find(params[:id])
    UsergroupMailer.invitation_mail(event).deliver!
    event.update_attributes! published: true

    redirect_to url_for(controller: "/admin/events", action: :edit, id: event.id), notice: "Published!"
  end
end
