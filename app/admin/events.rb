ActiveAdmin.register Event do
  form do |f|
    f.inputs "Details" do
      f.input :location
      f.input :user
      f.input :date
      f.input :name
      f.input :description
      f.input :published
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :date
    column :description
    default_actions
  end

  member_action :publish, method: :get do
    resource.publish_mailinglist(event_url(resource))
    redirect_to admin_dashboard_path, notice: "Published!"
  end

  collection_action :duplicate, method: :get do
    redirect_to edit_admin_event_path(Event.duplicate!)
  end
end
