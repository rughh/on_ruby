class Admin::EventsController < Admin::ApplicationController
  def duplicate
    event = Event.duplicate!
    redirect_to url_for(controller: '/admin/events', action: :edit, id: event.id)
  end

  def publish
    event = Event.find_by_slug(params[:id])
    UsergroupMailer.invitation_mail(event).deliver_now!
    event.update! published: true

    redirect_to url_for(controller: '/admin/events', action: :edit, id: event.id), notice: 'Published!'
  end
end
