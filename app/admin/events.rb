ActiveAdmin.register Event do
  member_action :publish, :method => :get do
    resource.publish(event_url(resource))
    redirect_to admin_dashboard_path, :notice => "Publiziert!"
  end
end
