ActiveAdmin.register Event do
  member_action :publish, method: :get do
    resource.publish_mailinglist(event_url(resource))
    redirect_to admin_dashboard_path, notice: "Published!"
  end

  collection_action :duplicate, method: :get do
    redirect_to edit_admin_event_path(Event.duplicate!)
  end
end
