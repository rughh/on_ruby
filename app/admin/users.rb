ActiveAdmin.register User do
  form do |f|
    f.inputs "Details" do
      f.input :nickname
      f.input :twitter
      f.input :github
      f.input :name
      f.input :url
      f.input :location
      f.input :description
      f.input :admin
      f.input :freelancer
      f.input :available
      f.input :hide_jobs
    end
    f.actions
  end

  index do
    column :id
    column :nickname
    column :twitter
    column :github
    column :name
    column :url
    column :location
    column :admin
    default_actions
  end
end
