ActiveAdmin.register Highlight do
  form do |f|
    f.inputs "Details" do
      f.input :description
      f.input :url
      f.input :start_at
      f.input :end_at
    end
    f.actions
  end

  index do
    column :id
    column :description
    column :url
    column :start_at
    column :end_at
    default_actions
  end

  controller do
    def new
      super do |format|
        @highlight.start_at = Date.today
        @highlight.end_at   = 2.days.from_now.beginning_of_day
      end
    end
  end

  member_action :disable, method: :get do
    resource.disable!
    redirect_to admin_dashboard_path, notice: "Disabled!"
  end
end
