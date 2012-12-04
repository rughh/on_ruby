ActiveAdmin.register Material do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :url
      f.input :user, as: :select, collection: User.all_for_selections
      f.input :event
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :description
    column :url
    default_actions
  end
end
