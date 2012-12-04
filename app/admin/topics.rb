ActiveAdmin.register Topic do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :user, as: :select, collection: User.all_for_selections
      f.input :event
    end
    f.buttons
  end

  index do
    column :id
    column :name
    column :description
    default_actions
  end
end
