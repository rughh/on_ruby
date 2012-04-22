ActiveAdmin.register Highlight do
  member_action :disable, method: :get do
    resource.disable!
    redirect_to admin_dashboard_path, notice: "Disabled!"
  end
end
