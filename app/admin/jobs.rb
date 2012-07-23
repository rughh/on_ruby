ActiveAdmin.register Job do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :url
      f.input :location
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :url
    column :location
    default_actions
  end
end
