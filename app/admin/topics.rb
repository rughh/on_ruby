ActiveAdmin.register Topic do
  member_action :copy, method: :get do
    resource.event = Event.last
    resource.save!
    redirect_to admin_dashboard_path, notice: "Added to last Event!"
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :user, as: :select, collection: User.all_for_selections
      f.input :event
    end
    f.actions
  end

  index do
    column :id
    column :name
    column :description
    default_actions
  end
end
