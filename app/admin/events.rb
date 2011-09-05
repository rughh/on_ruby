ActiveAdmin.register Event do
  member_action :publish, :method => :get do
    resource.publish(event_url(resource))
    redirect_to admin_dashboard_path, :notice => "Published!"
  end

  collection_action :duplicate, :method => :get do
    redirect_to edit_admin_event_path(Event.duplicate!)
  end

  sidebar :duplicate do
    link_to 'Event duplicated', duplicate_admin_events_path
  end
end
