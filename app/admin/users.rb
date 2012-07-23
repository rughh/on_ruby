ActiveAdmin.register User do
  form do |f|
    f.inputs "Details" do
      f.input :nickname
      f.input :name
      f.input :url
      f.input :location
      f.input :description
      f.input :github
      f.input :admin
      f.input :freelancer
      f.input :available
      f.input :hide_jobs
    end
    f.buttons
  end

  index do
    column :id
    column :nickname
    column :name
    column :url
    column :location
    column :github
    column :admin
    default_actions
  end
end
