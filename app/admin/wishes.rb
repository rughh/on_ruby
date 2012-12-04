ActiveAdmin.register Wish do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :done
      f.input :user, as: :select, collection: User.all_for_selections
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :description
    column :done
    default_actions
  end

  member_action :copy, method: :get do
    resource.copy_to_topic!
    redirect_to admin_dashboard_path, notice: "Copied!"
  end
end
