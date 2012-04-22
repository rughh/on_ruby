ActiveAdmin.register Wish do
  member_action :copy, method: :get do
    resource.copy_to_topic!
    redirect_to admin_dashboard_path, notice: "Copied!"
  end
end
